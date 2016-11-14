//
//  InterfaceController.m
//  Hardy Watch Extension
//
//  Created by Joseph Hardy on 10/7/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (IBAction)homeButton {
    if ([[WCSession defaultSession] isReachable]) {
        NSLog(@"homeButton pressed on watch");
        NSString *dataUrl = @"http://api.bart.gov/api/etd.aspx?cmd=etd&orig=12th&dir=n&key=MW9S-E7SL-26DU-VV8V";
        NSDictionary *applicationDict =  [NSDictionary dictionaryWithObject:dataUrl forKey:@"key1"];
        if(applicationDict) {
            [[WCSession defaultSession] sendMessage:applicationDict
                                       replyHandler:^(NSDictionary *replyHandler) {
                                           NSLog(@"replyHandler");
                                           NSLog(@"%@",replyHandler);
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               self.orangeLineLabel.text = replyHandler[@"orangeMinKey"];
                                               self.redLineLabel.text = replyHandler[@"redMinKey"];
                                           });
                                       }
                                       errorHandler:^(NSError *error) {
                                           NSLog(@"errorHandler");
                                           NSLog(@"%@",error);
                                       }
             ];
        }
    }
}

- (IBAction)workButton {
    if ([[WCSession defaultSession] isReachable]) {
        NSLog(@"workButton pressed on watch");
        NSString *dataUrl = @"http://api.bart.gov/api/etd.aspx?cmd=etd&orig=deln&dir=s&key=MW9S-E7SL-26DU-VV8V";
        NSDictionary *applicationDict =  [NSDictionary dictionaryWithObject:dataUrl forKey:@"key1"];
        if(applicationDict) {
            [[WCSession defaultSession] sendMessage:applicationDict
                                       replyHandler:^(NSDictionary *replyHandler) {
                                           NSLog(@"replyHandler");
                                           NSLog(@"%@",replyHandler);
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               self.orangeLineLabel.text = replyHandler[@"orangeMinKey"];
                                               self.redLineLabel.text = replyHandler[@"redMinKey"];
                                           });
                                       }
                                       errorHandler:^(NSError *error) {
                                           NSLog(@"errorHandler");
                                           NSLog(@"%@",error);
                                       }
             ];
        }
    }
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"willActivate");
    
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    NSLog(@"watch decativated");
}

- (void)session:(WCSession *)session didReceiveApplicationContext:(nonnull NSDictionary<NSString *,id> *)applicationContext {
    //  If there is context received, capture it here
    // This happens when app is activated
    //Print out the received dictionary
    NSLog(@"%@",applicationContext);
}

- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(NSError *)error {
    //When the session is first activated, do this
    dispatch_async(dispatch_get_main_queue(), ^{
        self.orangeLineLabel.text = @"Orange";
        self.redLineLabel.text = @"Red";
    });

}

@end



