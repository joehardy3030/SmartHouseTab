//
//  JLHWunderground.m
//  SHOC
//
//  Created by Joseph Hardy on 7/9/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "JLHWunderground.h"
#import "JLHNetworkManager.h"
#import "HourlyForecast.h"
#import "SimpleForecast.h"

@implementation JLHWunderground

- (void)getWundergroudHourlyForecast: (NSURL *)url success:(void (^)(NSMutableArray *wuWeatherArray))success failure:(void(^)(NSError* error))failure
{
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                                  NSURLResponse *response,
                                                                                  NSError *error) {
                                              
                                              // 4: Handle response here
                                              if(error == nil)
                                              {
                                                  HourlyForecast *hourlyForecast = [[HourlyForecast alloc] initFromData:data];
                                                  success(hourlyForecast.weatherArray);
                                                  NSLog(@"success");
                                              } //End if error == nil
                                              
                                              else{
                                                  failure(error);
                                                  NSLog(@"failure");
                                              } //End if error != nil
                                              
                                          }]; //End NSURLSessionDataTask
    
    // 3
    [downloadTask resume];
}

- (void)getWundergroudSimpleForecast: (NSURL *)url success:(void (^)(NSMutableArray *wuWeatherArray))success failure:(void(^)(NSError* error))failure
{
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                                  NSURLResponse *response,
                                                                                  NSError *error) {
                                              
                                              // 4: Handle response here
                                              if(error == nil)
                                              {
                                                  SimpleForecast *simpleForecast = [[SimpleForecast alloc] initFromData:data];
                                                  success(simpleForecast.weatherArray);
                                                  NSLog(@"success");
                                              } //End if error == nil
                                              
                                              else{
                                                  failure(error);
                                                  NSLog(@"failure");
                                              } //End if error != nil
                                              
                                          }]; //End NSURLSessionDataTask
    
    // 3
    [downloadTask resume];
}

@end
