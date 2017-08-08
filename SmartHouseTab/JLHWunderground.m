//
//  JLHWunderground.m
//  SHOC
//
//  Created by Joseph Hardy on 7/9/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "JLHWunderground.h"

@implementation JLHWunderground

- (NSMutableArray *)parseWundergroundSimpleForecast: (NSData *) data {
    NSMutableArray *wuWeatherArray;
    wuWeatherArray = [[NSMutableArray alloc] init];
    NSString *text = [[NSString alloc] initWithData:data
                                           encoding:NSUTF8StringEncoding];
    
    NSData *jData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jData options:0 error:nil];
    
    if ([json count] >0){
        //Get the current_observation and put in an NSDictionary
        NSDictionary *currentObservation = [json objectForKey:@"current_observation"];
        //NSLog(@"%@",currentObservation);
        
        //Put a header on the table
        NSDictionary *displayLocation = [currentObservation objectForKey:@"display_location"];
        NSString *displayLocationFull = [displayLocation objectForKey:@"full"];
        wuWeatherArray[0] = displayLocationFull;
        NSLog(@"%@",wuWeatherArray[0]);
     
        //Get current temperature string
        NSString *currentTemp = [currentObservation objectForKey:@"temperature_string"];
        NSString *currentTempString = @"Now    ";
        currentTempString = [currentTempString stringByAppendingString:currentTemp];
        wuWeatherArray[1] = currentTempString;
        
        //Get forecast for the next several days
        NSDictionary *forecast = [json objectForKey:@"forecast"];
        //NSDictionary *textForecast = [forecast objectForKey:@"txt_forecast"];
        //NSArray *forecastDay = [textForecast objectForKey:@"forecastday"];
        //NSLog(@"%@",forecastDay);
        
        //Pull out the simpleforecast which has the discrete values
        NSDictionary *simpleForecast = [forecast objectForKey:@"simpleforecast"];
        NSArray *simpleForecastDay = [simpleForecast objectForKey:@"forecastday"];
        
        //Extract date, am/pm, and high temperature in Fahrenheit
        //And add these to the UITableView through it's data source
        for (NSDictionary *forecastDayLoop in simpleForecastDay)
        {
            //   NSLog(@"%@",forecastDayLoop);
            NSDictionary *forecastDayLoopDate = [forecastDayLoop objectForKey:@"date"];
            NSString *forecastDayLoopName = [forecastDayLoopDate objectForKey:@"weekday_short"];
            NSString *forecastDayLoopString = [forecastDayLoopName stringByAppendingString:@"    "];
            NSDictionary *forecastDayLoopHigh = [forecastDayLoop objectForKey:@"high"];
            NSString *forecastDayLoopHighF = [forecastDayLoopHigh objectForKey:@"fahrenheit"];
            forecastDayLoopString = [forecastDayLoopString stringByAppendingString:forecastDayLoopHighF];
            forecastDayLoopString = [forecastDayLoopString stringByAppendingString:@" F"];
            NSString *forecastDayLoopIcon = [forecastDayLoop objectForKey:@"conditions"];
            forecastDayLoopString = [forecastDayLoopString stringByAppendingString:@"    "];
            forecastDayLoopString = [forecastDayLoopString stringByAppendingString:forecastDayLoopIcon];
            forecastDayLoopString = [forecastDayLoopString stringByAppendingString:@"    "];
            NSDictionary *forecastDayLoopMaxWind = [forecastDayLoop objectForKey:@"maxwind"];
            NSString *forecastDayLoopWindDir = [forecastDayLoopMaxWind objectForKey:@"dir"];
            forecastDayLoopString = [forecastDayLoopString stringByAppendingString:forecastDayLoopWindDir];
            forecastDayLoopString = [forecastDayLoopString stringByAppendingString:@" "];
            NSNumber *maxWind = [forecastDayLoopMaxWind objectForKey:@"mph"];
            NSString *forecastDayLoopMaxWindSpeed = [maxWind stringValue];
            forecastDayLoopString = [forecastDayLoopString stringByAppendingString:forecastDayLoopMaxWindSpeed];
            forecastDayLoopString = [forecastDayLoopString stringByAppendingString:@" MPH"];
            [wuWeatherArray addObject:forecastDayLoopString];
            //NSLog(@"%@",weatherArray[0]);
        }
    } //End if JSON count
    return(wuWeatherArray);
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
                                                  NSMutableArray *wuWeatherArray;
                                                  wuWeatherArray = [[NSMutableArray alloc] init];
                                                  wuWeatherArray = [self parseWundergroundSimpleForecast:data];
                                                  success(wuWeatherArray);
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

- (NSMutableArray *)parseWundergroundHourlyForecast: (NSData *) data {
    NSMutableArray *wuWeatherArray;
    wuWeatherArray = [[NSMutableArray alloc] init];
    NSString *text = [[NSString alloc] initWithData:data
                                           encoding:NSUTF8StringEncoding];
    
    NSData *jData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jData options:0 error:nil];
    
    if ([json count] >0){
        //Get the current_observation and put in an NSDictionary
        NSDictionary *currentObservation = [json objectForKey:@"current_observation"];
        //NSLog(@"%@",currentObservation);
        
        //Put a header on the table with current location
        NSDictionary *displayLocation = [currentObservation objectForKey:@"display_location"];
        NSString *displayLocationFull = [displayLocation objectForKey:@"full"];
        wuWeatherArray[0] = displayLocationFull;
        NSLog(@"%@",wuWeatherArray[0]);
        
        //Get forecast for the next several hours
        NSArray *hourlyForecast = [json objectForKey:@"hourly_forecast"];
        NSLog(@"%@",hourlyForecast);
        //Extract hour, high temperature in Fahrenheit, and condition
        //And add these to the UITableView through it's data source
        for (NSDictionary *forecastHourLoop in hourlyForecast)
        {
               NSLog(@"%@",forecastHourLoop);
            NSDictionary *forecastHourLoopDate = [forecastHourLoop objectForKey:@"FCTTIME"];
            NSString *forecastHourLoopName = [forecastHourLoopDate objectForKey:@"civil"];
            NSString *forecastHourLoopString = [forecastHourLoopName stringByAppendingString:@"   "];
            NSDictionary *forecastHourLoopTemp = [forecastHourLoop objectForKey:@"temp"];
            NSString *forecastHourLoopTempF = [forecastHourLoopTemp objectForKey:@"english"];
            forecastHourLoopString = [forecastHourLoopString stringByAppendingString:forecastHourLoopTempF];
            forecastHourLoopString = [forecastHourLoopString stringByAppendingString:@" F"];
            NSString *forecastHourLoopIcon = [forecastHourLoop objectForKey:@"condition"];
            forecastHourLoopString = [forecastHourLoopString stringByAppendingString:@"   "];
            forecastHourLoopString = [forecastHourLoopString stringByAppendingString:forecastHourLoopIcon];
            forecastHourLoopString = [forecastHourLoopString stringByAppendingString:@"   "];
            NSDictionary *forecastHourLoopWindDir = [forecastHourLoop objectForKey:@"wdir"];
            NSString *forecastHourLoopWindDirString = [forecastHourLoopWindDir objectForKey:@"dir"];
            forecastHourLoopString = [forecastHourLoopString stringByAppendingString:forecastHourLoopWindDirString];
            forecastHourLoopString = [forecastHourLoopString stringByAppendingString:@" "];
            NSDictionary *forecastHourLoopWindSpeed = [forecastHourLoop objectForKey:@"wspd"];
            NSString *windSpd = [forecastHourLoopWindSpeed objectForKey:@"english"];
            forecastHourLoopString = [forecastHourLoopString stringByAppendingString:windSpd];
            forecastHourLoopString = [forecastHourLoopString stringByAppendingString:@" MPH"];
            [wuWeatherArray addObject:forecastHourLoopString];
            //NSLog(@"%@",weatherArray[0]);
        }
    } //End if JSON count
    return(wuWeatherArray);
}

- (void)getWundergroudHourlyForecast: (NSURL *)url success:(void (^)(NSMutableArray *wuWeatherArray))success failure:(void(^)(NSError* error))failure
{
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                                  NSURLResponse *response,
                                                                                  NSError *error) {
                                              
                                              // 4: Handle response here
                                              if(error == nil)
                                              {
                                                  NSMutableArray *wuWeatherArray;
                                                  wuWeatherArray = [[NSMutableArray alloc] init];
                                                  wuWeatherArray = [self parseWundergroundHourlyForecast:data];
                                                  success(wuWeatherArray);
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
