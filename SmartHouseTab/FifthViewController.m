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
    
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Text";
    textField.returnKeyType = UIReturnKeyDone;
    
    textField.delegate = self;
    
    [self.view addSubview:textField];

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"%@", textField.text);
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)MoreButton:(UIButton *)sender {
    NSLog(@"More Buttone");
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
