//
//  LocationManager.h
//  SmartHouseTab
//
//  Created by Joseph Hardy on 7/26/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject
{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) CLLocation *currentLocation;

+ (instancetype)sharedInstance;

@end
