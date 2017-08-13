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
        // get array of users here
        self.printString = @"Min     Line     Cars\n";
        for (NSDictionary* bartDict in self.bartsArray)
        {
            
            NSString *colorString = [bartDict objectForKey:@"color"];
            if (![colorString isEqual: @"BLUE"] && ![colorString isEqual: @"GREEN"])
            {
                NSString *minutesString = [bartDict objectForKey:@"minutes"];
                NSString *carsString = [bartDict objectForKey:@"length"];
                self.printString = [self.printString stringByAppendingString:minutesString];
                self.printString = [self.printString stringByAppendingString:@"     "];
                self.printString = [self.printString stringByAppendingString:colorString];
                self.printString = [self.printString stringByAppendingString:@"     "];
                self.printString = [self.printString stringByAppendingString:carsString];
                self.printString = [self.printString stringByAppendingString:@"\n"];
            }
        }
        
    }
    return self;
}

@end
