//
//  ThirdViewController.h
//  House Hardy
//
//  Created by Joseph Hardy on 7/31/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *showPickerView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) NSArray *showPickerData;
@property (strong, nonatomic) NSArray *showURLStrings;
@property (strong, nonatomic) NSString *selectedShow;


@end
