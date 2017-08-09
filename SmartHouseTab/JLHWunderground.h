//
//  JLHWunderground.h
//  SHOC
//
//  Created by Joseph Hardy on 7/9/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLHWunderground : NSObject

@property (strong, nonatomic) NSData *weatherData;
@property (strong, nonatomic) NSMutableArray *weatherArray;

- (void)getWundergroudSimpleForecast: (NSURL *)url success:(void (^)(NSMutableArray *wuWeatherArray))success failure:(void(^)(NSError* error))failure;

- (void)getWundergroudHourlyForecast: (NSURL *)url success:(void (^)(NSMutableArray *wuWeatherArray))success failure:(void(^)(NSError* error))failure;


@end
