//
//  AppDelegate.h
//  SmartHouseTab
//
//  Created by Joseph Hardy on 7/10/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <WatchConnectivity/WatchConnectivity.h>

//#import "LocationManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, WCSessionDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

