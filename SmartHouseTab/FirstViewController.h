//
//  FirstViewController.h
//  SmartHouseTab
//
//  Created by Joseph Hardy on 7/10/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *weatherTableView;
@property (strong, nonatomic) NSMutableArray *weatherArray;
@property (strong, nonatomic) CLLocation *currentLocation;

//- (void)requestLocation;

@end

