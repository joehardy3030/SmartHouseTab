//
//  SecondViewController.m
//  SmartHouseTab
//
//  Created by Joseph Hardy on 7/10/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/*    CGRect buttonFrame = CGRectMake(60,60,90,31);
    self.bartHomeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.bartHomeButton.frame = buttonFrame;
    [self.bartHomeButton setTitle:@"Bart Home"
                       forState:UIControlStateNormal];
    [self.view addSubview:self.bartHomeButton]; */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (IBAction)bartHomeButton:(UIButton *)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.utilitiesTextView.text = @"Get Bart Home Info\n";
    }); }
 */

- (IBAction)bartHomeButton:(UIButton *)sender {
    
    self.utilitiesTextView.text = @"Get BART from 12th St\n";
    
    NSString *dataUrl = @"http://api.bart.gov/api/etd.aspx?cmd=etd&orig=12th&dir=n&key=MW9S-E7SL-26DU-VV8V";
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    JLHBartTimes *homeBartTimes = [[JLHBartTimes alloc] init];
    
    [homeBartTimes parseBartTimeString:url success:^(NSString *responseString) {
        NSLog(@"%@",responseString);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.utilitiesTextView.text = responseString;
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.utilitiesTextView.text = @"error";
        });
    }];

}

- (IBAction)bartWorkButton:(UIButton *)sender {
    
    self.utilitiesTextView.text = @"Get BART from El Cerrito del Norte\n";
    
    NSString *dataUrl = @"http://api.bart.gov/api/etd.aspx?cmd=etd&orig=deln&dir=s&key=MW9S-E7SL-26DU-VV8V";
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    JLHBartTimes *workBartTimes = [[JLHBartTimes alloc] init];
    
    [workBartTimes parseBartTimeString:url success:^(NSString *responseString) {
        NSLog(@"%@",responseString);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.utilitiesTextView.text = responseString;
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.utilitiesTextView.text = @"error";
        });
    }];
}

@end
