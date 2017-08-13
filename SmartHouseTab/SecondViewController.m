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
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    // Overwrite preferred status bar style and return ENUM LightContent
    return UIStatusBarStyleLightContent;
}

- (IBAction)bartHomeButton:(UIButton *)sender {
    
    self.utilitiesTextView.text = @"Get BART from 16th St\n";
    
    NSString *dataUrl = @"http://api.bart.gov/api/etd.aspx?cmd=etd&orig=16th&dir=n&key=MW9S-E7SL-26DU-VV8V";
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
            NSLog(@"%@",error);
        });
    }];

}
- (IBAction)bartCivicCenterButton:(UIButton *)sender {
    self.utilitiesTextView.text = @"Get BART from 16th St\n";
    
    NSString *dataUrl = @"http://api.bart.gov/api/etd.aspx?cmd=etd&orig=CIVC&dir=n&key=MW9S-E7SL-26DU-VV8V";
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
            NSLog(@"%@",error);
        });
    }];
}

- (IBAction)bartWorkButton:(UIButton *)sender {
    
    self.utilitiesTextView.text = @"Get BART from El Cerrito del Norte\n";
    
    NSString *dataUrl = @"http://api.bart.gov/api/etd.aspx?cmd=etd&orig=deln&dir=s&key=MW9S-E7SL-26DU-VV8V";
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    JLHNetworkManager *networkManager = [[JLHNetworkManager alloc] init];
    
    [networkManager getDataWithURL:url success:^(NSData *data) {
        BartTimes *bartTimes = [[BartTimes alloc] initFromData:data];
        NSLog(@"%@",bartTimes.printString);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.utilitiesTextView.text = bartTimes.printString;
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.utilitiesTextView.text = @"error";
            NSLog(@"%@",error);
        });
    }];

/*    [workBartTimes parseBartTimeString:url success:^(NSString *responseString) {
        NSLog(@"%@",responseString);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.utilitiesTextView.text = responseString;
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.utilitiesTextView.text = @"error";
            NSLog(@"%@",error);
        });
    }]; */
}

@end
