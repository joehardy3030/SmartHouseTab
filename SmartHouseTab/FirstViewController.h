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

//Data source and table view for displaying weather info
@property (strong, nonatomic) NSMutableArray *weatherArray;
@property (weak, nonatomic) IBOutlet UITableView *weatherTableView;

//Data and text view for location information
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) NSString *currentLongitude;
@property (strong, nonatomic) NSString *currentLatitude;
@property (weak, nonatomic) IBOutlet UITextView *locationTextView;
@property (nonatomic, strong) CLLocationManager* locationManager;

@end

