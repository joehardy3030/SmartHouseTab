//
//  BartTimes.m
//  Hardy House
//
//  Created by Joseph Hardy on 8/12/17.
//  Copyright © 2017 Joseph Hardy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BartTimes.h"
#import "XMLParser.h"

@implementation BartTimes : NSObject

- (instancetype)initFromData: (NSData*) data {
    if (self = [super init]) {
        self.fullText = [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
        self.displayTextArray = [[NSMutableArray alloc] init];
        self.cellItemArray = [[NSMutableArray alloc] init];
        
        NSLog(@"%@",self.fullText);
        
        // create and init NSXMLParser object
        NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
        
        // create and init our delegate
        XMLParser *parser = [[XMLParser alloc] initXMLParser];
        
        // set delegate
        [nsXmlParser setDelegate:parser];
        
        // parsing...
        BOOL xmlSuccess = [nsXmlParser parse];
        
        // test the result
        if (xmlSuccess) {
            NSMutableArray *barts = [parser barts];
            NSLog(@"No errors - BARTs count : %lu", (unsigned long)[barts count]);
            // get array of users here
        } else {
            NSLog(@"Error parsing document!");
        }
        
        self.bartsArray = [parser barts];
        
        self.printString = @"Min     Line     Cars\n";
        self.displayTextArray[0] = @"Min     Line     Cars\n";

        for (NSDictionary* bartDict in self.bartsArray)
        {
            
            NSString *colorString = [bartDict objectForKey:@"color"];
            if (![colorString isEqual: @"BLUE"] && ![colorString isEqual: @"GREEN"])
            {
                NSString *minutesString = [bartDict objectForKey:@"minutes"];
                NSString *carsString = [bartDict objectForKey:@"length"];
                NSString *bartLoopString = @"";
            //    NSDictionary *bartCellDict = [[NSDictionary alloc] init];
                
                bartLoopString = [bartLoopString stringByAppendingString:minutesString];
                bartLoopString = [bartLoopString stringByAppendingString:@"     "];
                bartLoopString = [bartLoopString stringByAppendingString:colorString];
                bartLoopString = [bartLoopString stringByAppendingString:@"     "];
                bartLoopString = [bartLoopString stringByAppendingString:carsString];
            
                //logic for image path based on colorString
                NSDictionary *bartCellDict = [NSDictionary dictionaryWithObjectsAndKeys:bartLoopString,@"displayString",
                                              nil];

                [self.cellItemArray addObject:bartCellDict];
                
                [self.displayTextArray addObject:bartLoopString];
            }
        }
        
    }
    return self;
}

@end
