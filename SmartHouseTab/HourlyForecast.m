//
//  HourlyForecast.m
//  Hardy House
//
//  Created by Joseph Hardy on 8/8/17.
//  Copyright © 2017 Joseph Hardy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HourlyForecast.h"

@implementation HourlyForecast : NSObject

- (instancetype)initFromData: (NSData*) data {
    if (self = [super init]) {
        self.weatherArray = [[NSMutableArray alloc] init];
        NSString *text = [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
        
        NSData *jData = [text dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jData options:0 error:nil];
        
        if ([json count] >0){
            //Get the current_observation and put in an NSDictionary
            self.currentObservation = [json objectForKey:@"current_observation"];
         //   NSLog(@"%@",self.currentObservation);
            
            //Put a header on the table with current location
            self.displayLocation = [self.currentObservation objectForKey:@"display_location"];
            self.displayLocationFull = [self.displayLocation objectForKey:@"full"];
           // self.weatherArray[0] = @"some text";
            self.weatherArray[0] = self.displayLocationFull;
            NSLog(@"%@",self.weatherArray[0]);
            
            //Get forecast for the next several hours
            self.hourlyForecast = [json objectForKey:@"hourly_forecast"];
           // NSLog(@"%@",self.hourlyForecast);
            //Extract hour, high temperature in Fahrenheit, and condition
            //And add these to the UITableView through it's data source
            for (NSDictionary *forecastHourLoop in self.hourlyForecast)
            {
             //   NSLog(@"%@",forecastHourLoop);
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
                [self.weatherArray addObject:forecastHourLoopString];
                NSLog(@"%@",self.weatherArray);
            }
            
    }
    
}
    return self;
}

@end
