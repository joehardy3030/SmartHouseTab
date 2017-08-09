//
//  JLHNetworkManager.h
//  Hardy House
//
//  Created by Joseph Hardy on 8/8/17.
//  Copyright © 2017 Joseph Hardy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLHNetworkManager : NSObject

- (void)getDataWithURL: (NSURL *)url success:(void (^)(NSData *data))success failure:(void(^)(NSError* error))failure;

@end
