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

 /*- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary *)message replyHandler:(nonnull void (^)(NSDictionary * __nonnull))replyHandler {

    // NSString *counterValue = [message objectForKey:@"counterValue"];
    
  //  if (!self.counterData) {
   //     self.counterData = [[NSMutableArray alloc] init];
   // }
    
    //Use this to update the UI instantaneously (otherwise, takes a little while)

   }*/

- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(NSError *)error {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.orangeLineLabel.text = @"10,30";
        self.redLineLabel.text = @"5,25";
    });

}

@end



