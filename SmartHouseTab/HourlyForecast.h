//
//  HourlyForecast.h
//  Hardy House
//
//  Created by Joseph Hardy on 8/8/17.
//  Copyright © 2017 Joseph Hardy. All rights reserved.
//

#ifndef HourlyForecast_h
#define HourlyForecast_h


#endif /* HourlyForecast_h */

@interface HourlyForecast : NSObject

@property (strong, nonatomic) NSDictionary *currentObservation;
@property (strong, nonatomic) NSDictionary *displayLocation;
@property (strong, nonatomic) NSString *displayLocationFull;
@property (strong, nonatomic) NSMutableArray *weatherDictArray;
@property (strong, nonatomic) NSMutableArray *weatherArray;
@property (strong, nonatomic) NSArray *hourlyForecast;

- (instancetype)initFromData: (NSData *)data;
@end
