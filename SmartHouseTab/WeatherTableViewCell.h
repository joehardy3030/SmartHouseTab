//
//  WeatherTableViewCell.h
//  Hardy House
//
//  Created by Joseph Hardy on 8/21/17.
//  Copyright © 2017 Joseph Hardy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;

@end
