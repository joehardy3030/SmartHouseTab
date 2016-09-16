//
//  FourthViewController.m
//  Hardy House
//
//  Created by Joseph Hardy on 8/20/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)GarageButton:(UIButton *)sender {
    NSLog(@"error");
    // 1
    NSString *dataUrl = @"http://10.0.0.11/arduino/press";
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
                                                      self.UtilitiesTextView.text = text;
                                                  });
                                              }
                                              else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      self.UtilitiesTextView.text = @"error";
                                                  });
                                              }
                                          }];
    
    // 3
    self.UtilitiesTextView.text = @"Garage Door\nPress\n";
    [downloadTask resume];
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