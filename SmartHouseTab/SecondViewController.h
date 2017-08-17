//
//  SecondViewController.h
//  SmartHouseTab
//
//  Created by Joseph Hardy on 7/10/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BartTimes.h"
#import "JLHBartTimes.h"
#import "JLHNetworkManager.h"

@interface SecondViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>

//@property (nonatomic) UIButton *bartHomeButton;

@property (weak, nonatomic) IBOutlet UILabel *utilitiesTextView;
@property (weak, nonatomic) IBOutlet UIPickerView *firstPickerView;

@property (strong, nonatomic) NSArray *stationPickerData;
//@property (strong, nonatomic) NSArray *stationURLStrings;
@property (strong, nonatomic) NSString *selectedStation;


@end

