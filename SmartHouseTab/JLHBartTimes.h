//
//  JLHBartTimes.h
//  SHOC
//
//  Created by Joseph Hardy on 6/21/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLParser.h"

@interface JLHBartTimes : NSObject 

- (void)parseBartTimeString: (NSURL *)url success:(void (^)(NSString *responseString))success failure:(void(^)(NSError* error))failure;


@end
