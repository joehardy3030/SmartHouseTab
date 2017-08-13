//
//  JLHBartTimes.m
//  SHOC
//
//  Created by Joseph Hardy on 6/21/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "JLHBartTimes.h"

@implementation JLHBartTimes
 
- (void)parseBartTimeString: (NSURL *)url success:(void (^)(NSString *responseString))success failure:(void(^)(NSError* error))failure
{

    // 2
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *downloadTask = [session dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                                  NSURLResponse *response,
                                                                                  NSError *error) {
                                              // 4: Handle response here
                                              if(error == nil)
                                              {
                                                NSString *text = [[NSString alloc] initWithData:data
                                                                                       encoding:NSUTF8StringEncoding];
                                        
                                                NSLog(@"%@",text);
                                                  
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
                                                    NSLog(@"No errors - user count : %lu", (unsigned long)[barts count]);
                                                      // get array of users here
                                                } else {
                                                    NSLog(@"Error parsing document!");
                                                }
                                                  
                                                NSMutableArray *barts = [parser barts];
                                                  // get array of users here
                                                NSString *printString = @"Min     Line     Cars\n";
                                                for (NSDictionary* bart in barts)
                                                {
                                                      
                                                    NSString *colorString = [bart objectForKey:@"color"];
                                                    if (![colorString isEqual: @"BLUE"] && ![colorString isEqual: @"GREEN"])
                                                    {
                                                        NSString *minutesString = [bart objectForKey:@"minutes"];
                                                        NSString *carsString = [bart objectForKey:@"length"];
                                                        printString = [printString stringByAppendingString:minutesString];
                                                        printString = [printString stringByAppendingString:@"     "];
                                                        printString = [printString stringByAppendingString:colorString];
                                                        printString = [printString stringByAppendingString:@"     "];
                                                        printString = [printString stringByAppendingString:carsString];
                                                        printString = [printString stringByAppendingString:@"\n"];
                                                    }
                                                }
                                          
                                                  success(printString);
                                              }
                                              else {
                                                  failure(error);
                                              }
                                          }];
    
    [downloadTask resume];
    
}

@end
