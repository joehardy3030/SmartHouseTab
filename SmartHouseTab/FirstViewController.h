//
//  FirstViewController.h
//  SmartHouseTab
//
//  Created by Joseph Hardy on 7/10/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLHBartTimes.h"

@interface FirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *weatherTableView;

@property (strong, nonatomic) NSMutableArray *weatherArray;

@property (weak, nonatomic) IBOutlet UITextView *WeatherTextView;


@end

