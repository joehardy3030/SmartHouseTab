//
//  SecondViewController.h
//  SmartHouseTab
//
//  Created by Joseph Hardy on 7/10/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BartTimes.h"
#import "JLHNetworkManager.h"

@interface SecondViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic) UIButton *bartHomeButton;
@property (weak, nonatomic) IBOutlet UITableView *BARTTableView;
@property (strong, nonatomic) NSMutableArray *BARTArray;
@property (weak, nonatomic) IBOutlet UIPickerView *firstPickerView;
@property (strong, nonatomic) NSArray *stationPickerData;
//@property (strong, nonatomic) NSArray *stationURLStrings;
@property (strong, nonatomic) NSString *selectedStation;

- (void)getAndDisplayBARTData:(NSURL *)url;

@end

