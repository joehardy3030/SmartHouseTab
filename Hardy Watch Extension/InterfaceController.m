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

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"willActivate");
    
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    
    if ([[WCSession defaultSession] isReachable]) {
        NSLog(@"watch side -- defaultSession isReachable");
        NSString *dataUrl = @"http://api.bart.gov/api/etd.aspx?cmd=etd&orig=12th&dir=n&key=MW9S-E7SL-26DU-VV8V";
//        NSURL *url = [NSURL URLWithString:dataUrl];
        
        NSDictionary *applicationDict =  [NSDictionary dictionaryWithObject:dataUrl forKey:@"key1"];
        if(applicationDict) {
        [[WCSession defaultSession] sendMessage:applicationDict
                                   replyHandler:^(NSDictionary *replyHandler) {
                                       NSLog(@"replyHandler");
                                       NSLog(@"%@",replyHandler);
                                   }
                                   errorHandler:^(NSError *error) {
                                       NSLog(@"errorHandler");
                                       NSLog(@"%@",error);
                                   }
         ];
        }
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    NSLog(@"watch decativated");
}

//  If there is context received, capture it here
// This happens when app is activated 
- (void)session:(WCSession *)session didReceiveApplicationContext:(nonnull NSDictionary<NSString *,id> *)applicationContext {
    //Print out the received dictionary
    NSLog(@"%@",applicationContext);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.orangeLineLabel.text = applicationContext;
        self.redLineLabel.text = @"5,25";
    });

}

- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(NSError *)error {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.orangeLineLabel.text = @"10,30";
        self.redLineLabel.text = @"5,25";
    });

}

@end



