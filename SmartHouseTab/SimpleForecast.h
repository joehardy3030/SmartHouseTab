//
//  SimpleForecast.h
//  Hardy House
//
//  Created by Joseph Hardy on 8/9/17.
//  Copyright © 2017 Joseph Hardy. All rights reserved.
//

#ifndef SimpleForecast_h
#define SimpleForecast_h


#endif /* SimpleForecast_h */

@interface SimpleForecast : NSObject

@property (strong, nonatomic) NSDictionary *currentObservation;
@property (strong, nonatomic) NSDictionary *displayLocation;
@property (strong, nonatomic) NSString *displayLocationFull;
@property (strong, nonatomic) NSMutableArray *weatherArray;
@property (strong, nonatomic) NSString *currentTemp;
@property (strong, nonatomic) NSString *currentTempString;
@property (strong, nonatomic) NSDictionary *forecast;
@property (strong, nonatomic) NSDictionary *simpleForecast;
@property (strong, nonatomic) NSArray *simpleForecastDay;

//@property (strong, nonatomic) NSArray *hourlyForecast;

- (instancetype)initFromData: (NSData *)data;
@end
