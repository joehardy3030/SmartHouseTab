//
//  FirstViewController.m
//  SmartHouseTab
//
//  Created by Joseph Hardy on 7/10/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "FirstViewController.h"
#import "JLHNetworkManager.h"
#import "HourlyForecast.h"
#import "SimpleForecast.h"
#import "WeatherTableViewCell.h"

@interface FirstViewController ()
//@property(nonatomic, strong) CLLocationManager* locationManager;
//- (void)initializeTextViewDataSource;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    NSURL *url;
    [super viewDidLoad];
    [self initializeTextViewDataSource];
    // load NIB file for cells
    UINib *nib = [UINib nibWithNibName:@"WeatherTableViewCell" bundle:nil];
    // Register the NIB, which contains the cell
    [self.weatherTableView registerNib:nib forCellReuseIdentifier:@"WeatherTableViewCell"];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
  //  [self.locationManager requestLocation];
    url = [self getURLForHourlyForecast];
    [self getAndDisplayHourlyForecast:url];
 }

- (UIStatusBarStyle)preferredStatusBarStyle {
    // Overwrite preferred status bar style and return ENUM LightContent
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeTextViewDataSource
{
    // Set up the weatherArray and set the dataSource for the current
    self.weatherArray = [[NSMutableArray alloc] init];
    self.weatherTableView.dataSource = self;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
    }
    self.currentLocation = [self.locationManager location];
    
    self.currentLatitude = [NSString stringWithFormat:@"%.6f",self.currentLocation.coordinate.latitude];
    self.currentLongitude = [NSString stringWithFormat:@"%.6f",self.currentLocation.coordinate.longitude];
    NSString *locationTextString = @"Latitude: ";
    locationTextString = [locationTextString stringByAppendingString:self.currentLatitude];
    locationTextString = [locationTextString stringByAppendingString:@"\nLongitude: "];
    locationTextString = [locationTextString stringByAppendingString:self.currentLongitude];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@",[self.locationManager location]);
        self.locationTextView.text = locationTextString;
    });
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // typically you need know which item the user has selected.
    // this method allows you to keep track of the selection
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
}

// This will tell your UITableView how many rows you wish to have in each section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.weatherArray count];
}

// This will tell your UITableView what data to put in which cells in your table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // static NSString *CellIdentifer = @"CellIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherTableViewCell"];
    
    // Using a cell identifier will allow your app to reuse cells as they come and go from the screen.
    if (cell == nil)
    {
      //  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
          cell = [[WeatherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WeatherTableViewCell"];
    }
    
    // Deciding which data to put into this particular cell.
    // If it the first row, the data input will be "Data1" from the array.
    NSUInteger row = [indexPath row];
    
    NSDictionary *item = (NSDictionary *)[self.weatherArray objectAtIndex:row]; //item Dictionary for row
    
//    cell.textLabel.text = [item objectForKey:@"displayString"]; //textLabel text from Dictionary
  //  cell.textLabel.font = [UIFont fontWithName: @"Avenir" size:14];
//    cell.temperatureLabel.text = [item objectForKey:@"displayString"]; //textLabel text from Dictionary
    cell.timeLabel.text = [item objectForKey:@"time"]; //textLabel text from Dictionary
    cell.conditionLabel.text = [item objectForKey:@"condition"]; //textLabel text from Dictionary
    cell.temperatureLabel.text = [[item objectForKey:@"tempF"] stringByAppendingString:@" F"]; //textLabel text from Dictionary
    cell.windLabel.text = [item objectForKey:@"wind"]; //textLabel text from Dictionary

    //    cell.temperatureLabel.font = [UIFont fontWithName: @"Avenir" size:14];

    NSString *imageName = [item objectForKey:@"imageKey"]; //name of image for UIImageView
    UIImage *theImage = [UIImage imageNamed:imageName]; //UIImage for UIImageView
//    cell.imageView.image = theImage;
    cell.weatherIcon.image = theImage;

    return cell;
}

- (IBAction)requestLocationButton:(UIButton *)sender {
   
    [self.locationManager requestLocation];
}

- (IBAction)startLocationButton:(UIButton *)sender {
    
    [self.locationManager startUpdatingLocation];
}

- (IBAction)stopLocationButton:(UIButton *)sender {
  
    [self.locationManager stopUpdatingLocation];
}

- (IBAction)resetLocationButton:(UIButton *)sender {
    self.currentLocation = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.locationTextView.text = NULL;
    });
}


- (IBAction)WeatherTest:(UIButton *)sender {
    NSURL *url;
    url = [self getURLForSimpleForecast];
    [self getAndDisplaySimpleForecast:url];
}

- (NSURL *)getURLForSimpleForecast {
    NSString *dataUrl;
    NSURL *url;
    
    if (self.currentLocation != nil) {
        NSLog(@"Current location instance variable: %@",self.currentLocation);
        dataUrl = @"http://api.wunderground.com/api/ffd1b93b6a497308/conditions/forecast/q/";
        dataUrl = [dataUrl stringByAppendingString:self.currentLatitude];
        dataUrl = [dataUrl stringByAppendingString:@","];
        dataUrl = [dataUrl stringByAppendingString:self.currentLongitude];
        dataUrl = [dataUrl stringByAppendingString:@".json"];
    }
    else {
        dataUrl = @"http://api.wunderground.com/api/ffd1b93b6a497308/conditions/forecast/q/CA/El_Cerrito.json";
    }
    NSLog(@"Current location instance variable: %@",dataUrl);
    
    url = [NSURL URLWithString:dataUrl];
    NSLog(@"Current location instance variable: %@",dataUrl);
    return url;
}

- (void)getAndDisplaySimpleForecast:(NSURL *)url {
    
    JLHNetworkManager *networkManager = [[JLHNetworkManager alloc] init];
    
    [networkManager getDataWithURL:url
                           success:^(NSData* weatherSuccess) {
                               SimpleForecast *hourlyForecast = [[SimpleForecast alloc] initFromData:weatherSuccess];
                               self.weatherArray = hourlyForecast.weatherDictArray;
                               //NSString *locationString = hourlyForecast.displayLocationFull;
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   self.currentLocationLabel.text = hourlyForecast.displayLocationFull;
                                   [self.weatherTableView reloadData];
                               });
                           }
                           failure:^(NSError *error) {
                               NSLog(@"%@",error);
                               self.weatherArray[0] = @"error";
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   self.currentLocationLabel.text = @"Error";
                                   [self.weatherTableView reloadData];
                               });
                           }];
}

- (IBAction)hourlyForecastButton:(UIButton *)sender {
    NSURL *url;
    url = [self getURLForHourlyForecast];
    [self getAndDisplayHourlyForecast:url];
 }

- (NSURL *)getURLForHourlyForecast {
    NSString *dataUrl;
    NSURL *url;
    
    if (self.currentLocation != nil) {
        NSLog(@"Current location instance variable: %@",self.currentLocation);
        dataUrl = @"http://api.wunderground.com/api/ffd1b93b6a497308/conditions/forecast/hourly/q/";
        dataUrl = [dataUrl stringByAppendingString:self.currentLatitude];
        dataUrl = [dataUrl stringByAppendingString:@","];
        dataUrl = [dataUrl stringByAppendingString:self.currentLongitude];
        dataUrl = [dataUrl stringByAppendingString:@".json"];
    }
    else {
        dataUrl = @"http://api.wunderground.com/api/ffd1b93b6a497308/conditions/forecast/hourly/q/CA/El_Cerrito.json";
    }
    url = [NSURL URLWithString:dataUrl];
    NSLog(@"Current location instance variable: %@",dataUrl);
    return url;
}

- (void)getAndDisplayHourlyForecast:(NSURL *)url {
    
    JLHNetworkManager *networkManager = [[JLHNetworkManager alloc] init];
    
    [networkManager getDataWithURL:url
                           success:^(NSData* weatherSuccess) {
                               HourlyForecast *hourlyForecast = [[HourlyForecast alloc] initFromData:weatherSuccess];
                               self.weatherArray = hourlyForecast.weatherDictArray;
                               //NSString *locationString = hourlyForecast.displayLocationFull;
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   self.currentLocationLabel.text = hourlyForecast.displayLocationFull;
                                   [self.weatherTableView reloadData];
                               });
                           }
                           failure:^(NSError *error) {
                               NSLog(@"%@",error);
                               self.weatherArray[0] = @"error";
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   self.currentLocationLabel.text = @"Error";
                                   [self.weatherTableView reloadData];
                               });
                           }];
}

@end
