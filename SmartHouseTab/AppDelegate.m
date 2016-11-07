//
//  AppDelegate.m
//  SmartHouseTab
//
//  Created by Joseph Hardy on 7/10/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   // [LocationManager sharedInstance];
    //return true;
    UIUserNotificationType types = (UIUserNotificationType) (UIUserNotificationTypeBadge |
                                                             UIUserNotificationTypeSound | UIUserNotificationTypeAlert);
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    // Create a WCSession instance
    // For communication with the Watch
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    
    return YES;
}

- (void)sessionDidDeactivate:(WCSession *)session {
    NSLog(@"App watch session did deactivate");
    
}

- (void)sessionDidBecomeInactive:(WCSession *)session {
    NSLog(@"App watch session did become incative");
}


- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(NSError *)error {
    NSLog(@"Phone side watch activation");
    if (error) {
        NSLog(@"%@",error);
    }
    
    NSString *dataUrl = @"http://api.bart.gov/api/etd.aspx?cmd=etd&orig=12th&dir=n&key=MW9S-E7SL-26DU-VV8V";
    NSURL *url = [NSURL URLWithString:dataUrl];
    JLHBartTimes *homeBartTimes = [[JLHBartTimes alloc] init];
    
    [homeBartTimes parseBartTimeString:url success:^(NSString *responseString) {
        NSLog(@"%@",responseString);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *applicationDict = responseString;
            [[WCSession defaultSession] updateApplicationContext:applicationDict error:nil];
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",error);
        });
    }];
    
}

//NSDictionary *applicationDict = // Create a dict of application data
//[[WCSession defaultSession] updateApplicationContext:applicationDict error:nil];


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
