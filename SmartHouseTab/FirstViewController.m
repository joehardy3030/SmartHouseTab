//
//  FirstViewController.m
//  SmartHouseTab
//
//  Created by Joseph Hardy on 7/10/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.WeatherTextView.text = @"Ready";
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)WeatherTest:(UIButton *)sender {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.WeatherTextView.text = @"Button Press";
        // Asynchronous action here
    });
}

@end
