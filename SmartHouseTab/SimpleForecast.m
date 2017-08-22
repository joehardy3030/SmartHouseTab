//
//  SimpleForecast.m
//  Hardy House
//
//  Created by Joseph Hardy on 8/9/17.
//  Copyright © 2017 Joseph Hardy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleForecast.h"

@implementation SimpleForecast : NSObject

- (instancetype)initFromData: (NSData*) data {
    if (self = [super init]) {
        self.weatherArray = [[NSMutableArray alloc] init];
        self.weatherDictArray = [[NSMutableArray alloc] init];
        NSString *text = [[NSString alloc] initWithData:data
                                           encoding:NSUTF8StringEncoding];
        NSData *jData = [text dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jData options:0 error:nil];
        
        if ([json count] >0){
            //Get the current_observation and put in an NSDictionary
            self.currentObservation = [json objectForKey:@"current_observation"];
            //NSLog(@"%@",currentObservation);
            
            //Put a header on the table
            self.displayLocation = [self.currentObservation objectForKey:@"display_location"];
            self.displayLocationFull = [self.displayLocation objectForKey:@"full"];
            self.weatherArray[0] = self.displayLocationFull;
            NSLog(@"%@",self.weatherArray[0]);
            
            //Get current temperature string
            self.currentTemp = [self.currentObservation objectForKey:@"temperature_string"];
            self.currentTempString = @"Now    ";
            self.currentTempString = [self.currentTempString stringByAppendingString:self.currentTemp];
            self.weatherArray[1] = self.currentTempString;
            
            //Get forecast for the next several days
            self.forecast = [json objectForKey:@"forecast"];
            
            //Pull out the simpleforecast which has the discrete values
            self.simpleForecast = [self.forecast objectForKey:@"simpleforecast"];
            self.simpleForecastDay = [self.simpleForecast objectForKey:@"forecastday"];
            
            //Extract date, am/pm, and high temperature in Fahrenheit
            //And add these to the UITableView through it's data source
            for (NSDictionary *forecastDayLoop in self.simpleForecastDay)
            {
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
                [self.weatherArray addObject:forecastDayLoopString];
                

                //logic for image path based on colorString
                NSString *imageName = @"";
                if ([forecastDayLoopIcon isEqual: @"Clear"])
                    imageName = @"clear.png";
                else if ([forecastDayLoopIcon isEqual: @"Fog"])
                    imageName = @"fog.png";
                else if ([forecastDayLoopIcon isEqual: @"Overcast"])
                    imageName = @"fog.png";
                else if ([forecastDayLoopIcon isEqual: @"Partly Cloudy"])
                    imageName = @"partlycloudy.png";
                else if ([forecastDayLoopIcon isEqual: @"Mostly Cloudy"])
                    imageName = @"mostlycloudy.png";
                else if ([forecastDayLoopIcon isEqual: @"Rain Cloudy"])
                    imageName = @"rain.png";
                else
                    imageName = @"clear.png";;
                
                NSDictionary *weatherCellDict = [NSDictionary dictionaryWithObjectsAndKeys:forecastDayLoopString,@"displayString",imageName,@"imageKey",nil];
            
                [self.weatherDictArray addObject:weatherCellDict];

            }
        } //End if JSON count
    }
    return self;
}

@end
