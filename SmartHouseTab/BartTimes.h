//
//  BartTimes.h
//  Hardy House
//
//  Created by Joseph Hardy on 8/12/17.
//  Copyright © 2017 Joseph Hardy. All rights reserved.
//

#ifndef BartTimes_h
#define BartTimes_h


#endif /* BartTimes_h */
@interface BartTimes : NSObject

@property (strong, nonatomic) NSString *fullText;
@property (strong, nonatomic) NSString *printString;
//@property (strong, nonatomic) NSDictionary *displayLocation;
@property (strong, nonatomic) NSMutableArray *bartsArray;
@property (strong, nonatomic) NSMutableArray *displayTextArray;
//@property (strong, nonatomic) NSArray *hourlyForecast;

- (instancetype)initFromData: (NSData *)data;
@end
