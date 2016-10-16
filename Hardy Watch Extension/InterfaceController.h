//
//  InterfaceController.h
//  Hardy Watch Extension
//
//  Created by Joseph Hardy on 10/7/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *orangeLineLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *redLineLabe;

@end
