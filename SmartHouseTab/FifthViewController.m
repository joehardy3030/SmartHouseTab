//
//  FifthViewController.m
//  Hardy House
//
//  Created by Joseph Hardy on 8/20/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "FifthViewController.h"

@interface FifthViewController () <UITextFieldDelegate>

@end

@implementation FifthViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

-(void)dismissKeyboard
{
    [self.moreTextView resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GetTasks:(id)sender {
    // 1
    
    NSString *dataUrl = FLASK_URL;
    dataUrl = [dataUrl stringByAppendingString:@"/todo/api/v1.0/tasks"];
    
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    // 2
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              // 4: Handle response here
                                              if(error == nil)
                                              {
                                                  NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                  NSLog(@"Data = %@",text);
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      self.moreTextView.text = text;
                                                  });
                                              }
                                              else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      self.moreTextView.text = @"error";
                                                  });
                                              }
                                          }];
    
    // 3
    self.moreTextView.text = @"Flask";
    [downloadTask resume];
}

- (IBAction)PostTasks:(id)sender {
    // 1
    NSError *error;
    NSString *dataUrl = FLASK_URL;
    dataUrl = [dataUrl stringByAppendingString:@"/todo/api/v1.0/tasks/p"];
    
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys: self.moreTextView.text, @"title",
                             nil];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    [request setHTTPBody:postData];
    
    // 2
    NSURLSessionDataTask *postDataTask = [[NSURLSession sharedSession]
                                          dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              // 4: Handle response here
                                              if(error == nil)
                                              {
                                                  NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                  NSLog(@"Data = %@",text);
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      self.moreTextView.text = text;
                                                  });
                                              }
                                              else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      self.moreTextView.text = @"error";
                                                  });
                                              }
                                          }];
    
    // 3
    self.moreTextView.text = @"Flask";
    [postDataTask resume];
}

- (IBAction)convertCToFButton:(UIButton *)sender {
    double c;
    double f;
    c = [self.moreTextView.text doubleValue];
    f = 32.0 + (9.0/5.0)*c;
    NSString *fString = [NSString stringWithFormat:@"%f", f];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.moreTextView.text = fString;
    });
}

- (IBAction)convertFtoCButton:(UIButton *)sender {
    double c;
    double f;
    f = [self.moreTextView.text doubleValue];
    c = (f-32.0) * (5.0/9.0);
    NSString *cString = [NSString stringWithFormat:@"%f", c];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.moreTextView.text = cString;
    });
}

- (IBAction)MoreButton:(UIButton *)sender {
    NSLog(@"More Button");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
