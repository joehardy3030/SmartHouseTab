//
//  JLHNetworkManager.m
//  Hardy House
//
//  Created by Joseph Hardy on 8/8/17.
//  Copyright © 2017 Joseph Hardy. All rights reserved.
//

#import "JLHNetworkManager.h"

@implementation JLHNetworkManager;

- (void)getDataWithURL: (NSURL *)url success:(void (^)(NSData *data))success failure:(void(^)(NSError* error))failure
{
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                           dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                                   NSURLResponse *response,
                                                                                   NSError *error) {
                                               // 4: Handle response here
                                               if(error == nil)
                                               {
                                                   success(data);
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

