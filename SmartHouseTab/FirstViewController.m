//
//  FirstViewController.m
//  SmartHouseTab
//
//  Created by Joseph Hardy on 7/10/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "FirstViewController.h"
//#import "LocationManager.h"

@interface FirstViewController ()
@property(nonatomic, strong) CLLocationManager* locationManager;
- (void)configureView;
@end

@implementation FirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //[self startStandardUpdates];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
   // [self.locationManager startUpdatingLocation];
    
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView
{
    // Update the user interface for the detail item.
    self.weatherArray = [[NSMutableArray alloc] initWithObjects:@"", nil];
    _weatherTableView.dataSource = self;
//    [self.locationManager requestLocation];

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
    _currentLocation = [self.locationManager location];
    
    _currentLatitude = [NSString stringWithFormat:@"%.4f",self.currentLocation.coordinate.latitude];
    _currentLongitude = [NSString stringWithFormat:@"%.4f",self.currentLocation.coordinate.longitude];
    NSString *locationTextString = @"Latitude: ";
    locationTextString = [locationTextString stringByAppendingString:_currentLatitude];
    locationTextString = [locationTextString stringByAppendingString:@"\nLongitude: "];
    locationTextString = [locationTextString stringByAppendingString:_currentLongitude];
    
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
    static NSString *CellIdentifer = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    // Using a cell identifier will allow your app to reuse cells as they come and go from the screen.
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    
    // Deciding which data to put into this particular cell.
    // If it the first row, the data input will be "Data1" from the array.
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.weatherArray objectAtIndex:row];
    cell.textLabel.font = [UIFont fontWithName: @"Avenir" size:14];
    
    return cell;
}

- (IBAction)locationButton:(UIButton *)sender {
    
    [self.locationManager requestLocation];
}

- (IBAction)WeatherTest:(UIButton *)sender {
    
    NSString *dataUrl;
    if (_currentLocation != NULL) {
        NSLog(@"Current location instance variable: %@",_currentLocation);
        dataUrl = @"http://api.wunderground.com/api/ffd1b93b6a497308/conditions/forecast/q/";
        dataUrl = [dataUrl stringByAppendingString:_currentLatitude];
        dataUrl = [dataUrl stringByAppendingString:@","];
        dataUrl = [dataUrl stringByAppendingString:_currentLongitude];
        dataUrl = [dataUrl stringByAppendingString:@".json"];
    }
    else {
    dataUrl = @"http://api.wunderground.com/api/ffd1b93b6a497308/conditions/forecast/q/CA/El_Cerrito.json";
    }
    NSLog(@"Current location instance variable: %@",dataUrl);

    NSURL *url = [NSURL URLWithString:dataUrl];
    
/*    JLHBartTimes *homeBartTimes = [[JLHBartTimes alloc] init];
    
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
*/
    //  [self configureView];
    /*dispatch_async(dispatch_get_main_queue(), ^{
        [self.weatherTableView reloadData];
    }); */
    
    /*self.weatherArray[0] = @"Error loading weather data";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.weatherTableView reloadData];
    }); */
    
    //self.weatherArray = nil;
    // 2
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                                  NSURLResponse *response,
                                                                                  NSError *error) {
                                              // 4: Handle response here
                                              if(error == nil)
                                              {
                                                  [self configureView];
                                                  NSString *text = [[NSString alloc] initWithData:data
                                                                                         encoding:NSUTF8StringEncoding];
                                                  
                                                  NSData *jData = [text dataUsingEncoding:NSUTF8StringEncoding];
                                                  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jData options:0 error:nil];
                                                  
                                                  if ([json count] >0){
                                                  //Get the current_observation and put in an NSDictionary
                                                  NSDictionary *currentObservation = [json objectForKey:@"current_observation"];
                                                  //NSLog(@"%@",currentObservation);

                                                  //Put a header on the table
                                                  NSDictionary *displayLocation = [currentObservation objectForKey:@"display_location"];
                                                  NSString *displayLocationFull = [displayLocation objectForKey:@"full"];
                                                  self.weatherArray[0] = displayLocationFull;
                                                      
                                                  //Get current temperature string
                                                  NSString *currentTemp = [currentObservation objectForKey:@"temperature_string"];
                                                  NSString *currentTempString = @"Now    ";
                                                  currentTempString = [currentTempString stringByAppendingString:currentTemp];
                                                  self.weatherArray[1] = currentTempString;
                                                  
                                                  //Get forecast for the next several days
                                                  NSDictionary *forecast = [json objectForKey:@"forecast"];
                                                  //NSDictionary *textForecast = [forecast objectForKey:@"txt_forecast"];
                                                  //NSArray *forecastDay = [textForecast objectForKey:@"forecastday"];
                                                  //NSLog(@"%@",forecastDay);
                                                 
                                                  //Pull out the simpleforecast which has the discrete values
                                                  NSDictionary *simpleForecast = [forecast objectForKey:@"simpleforecast"];
                                                  NSArray *simpleForecastDay = [simpleForecast objectForKey:@"forecastday"];
                                                  
                                                  //Extract date, am/pm, and high temperature in Fahrenheit
                                                  //And add these to the UITableView through it's data source
                                                  for (NSDictionary *forecastDayLoop in simpleForecastDay)
                                                  {
                                                   //   NSLog(@"%@",forecastDayLoop);
                                                      NSDictionary *forecastDayLoopDate = [forecastDayLoop objectForKey:@"date"];
                                                      NSString *forecastDayLoopName = [forecastDayLoopDate objectForKey:@"weekday_short"];
                                                      NSString *forecastDayLoopString = [forecastDayLoopName stringByAppendingString:@"    "];
                                                      NSDictionary *forecastDayLoopHigh = [forecastDayLoop objectForKey:@"high"];
                                                      NSString *forecastDayLoopHighF = [forecastDayLoopHigh objectForKey:@"fahrenheit"];
                                                      forecastDayLoopString = [forecastDayLoopString stringByAppendingString:forecastDayLoopHighF];
                                                      forecastDayLoopString = [forecastDayLoopString stringByAppendingString:@" F"];
                                                      NSString *forecastDayLoopIcon = [forecastDayLoop objectForKey:@"icon"];
                                                      forecastDayLoopString = [forecastDayLoopString stringByAppendingString:@"    "];
                                                      forecastDayLoopString = [forecastDayLoopString stringByAppendingString:forecastDayLoopIcon];
                                                      forecastDayLoopString = [forecastDayLoopString stringByAppendingString:@"    "];
                                                      NSDictionary *forecastDayLoopMaxWind = [forecastDayLoop objectForKey:@"maxwind"];
                                                      NSString *forecastDayLoopWindDir = [forecastDayLoopMaxWind objectForKey:@"dir"];
                                                      forecastDayLoopString = [forecastDayLoopString stringByAppendingString:forecastDayLoopWindDir];
                                                      forecastDayLoopString = [forecastDayLoopString stringByAppendingString:@" "];
                                                      NSNumber *maxWind = [forecastDayLoopMaxWind objectForKey:@"mph"];
                                                      NSString *forecastDayLoopMaxWindSpeed = [maxWind stringValue];
                                                      forecastDayLoopString = [forecastDayLoopString stringByAppendingString:forecastDayLoopMaxWindSpeed];
                                                      forecastDayLoopString = [forecastDayLoopString stringByAppendingString:@" MPH"];
                                                      [self.weatherArray addObject:forecastDayLoopString];
                                                  }
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                     [self.weatherTableView reloadData];
                                                  });
                                              }
                                              else{
                                                  self.weatherArray[0] = @"Error loading weather data";
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [self.weatherTableView reloadData];
                                                  });
                                              }
                                              }
                                          }];
    
    // 3

    [downloadTask resume];
}




@end
