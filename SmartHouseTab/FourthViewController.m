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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
  
    //Programmatically add nav bar
/*    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    navBar.backgroundColor = [UIColor blackColor];
    [self.view addSubview:navBar];
*/

}

-(void)dismissKeyboard
{
    [self.UtilitiesTextView resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // Overwrite preferred status bar style and return ENUM LightContent
    return UIStatusBarStyleLightContent;
}

- (IBAction)GetFlaskJSON:(UIButton *)sender {
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
    self.UtilitiesTextView.text = @"Flask";
    [downloadTask resume];
}

- (IBAction)HeaterOnButton:(UIButton *)sender {
    // 1
    
    NSString *dataUrl = DOWNSTAIRS_ARDUINO;
    dataUrl = [dataUrl stringByAppendingString:@"/arduino/on"];
    
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
    self.UtilitiesTextView.text = @"Heater On";
    [downloadTask resume];
}

- (IBAction)HeaterOffButton:(UIButton *)sender {
    // 1
    
    NSString *dataUrl = DOWNSTAIRS_ARDUINO;
    dataUrl = [dataUrl stringByAppendingString:@"/arduino/off"];

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
    self.UtilitiesTextView.text = @"Heater Off";
    [downloadTask resume];
}

- (IBAction)GarageButton:(UIButton *)sender {
    NSLog(@"error");
    // 1
    NSString *dataUrl = UPSTAIRS_ARDUINO;
    dataUrl = [dataUrl stringByAppendingString:@"/arduino/press"];

  //  NSString *dataUrl = @"http://10.0.0.11/arduino/press";
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
