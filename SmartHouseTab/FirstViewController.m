//
//  FirstViewController.m
//  SmartHouseTab
//
//  Created by Joseph Hardy on 7/10/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
- (void)configureView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.WeatherTextView.text = @"Ready";
    [self configureView];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView
{
    // Update the user interface for the detail item.
    self.weatherArray = [[NSMutableArray alloc] initWithObjects:@"Hello World",@"Goodbye World", nil];
    //self.weatherArray = [[NSMutableArray alloc] initWithObjects:self.WeatherTextView.text, nil];
    _weatherTableView.dataSource = self;
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
    
    return cell;
}


- (IBAction)WeatherTest:(UIButton *)sender {
    NSString *dataUrl = @"http://api.wunderground.com/api/ffd1b93b6a497308/conditions/forecast/q/CA/El_Cerrito.json";
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    // 2
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                                  NSURLResponse *response,
                                                                                  NSError *error) {
                                              // 4: Handle response here
                                              if(error == nil)
                                              {
                                                  NSString *text = [[NSString alloc] initWithData:data
                                                                                         encoding:NSUTF8StringEncoding];
                                                  
                                                  NSData *jData = [text dataUsingEncoding:NSUTF8StringEncoding];
                                                  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jData options:0 error:nil];
                                                  
                                                  NSDictionary *currentObservation = [json objectForKey:@"current_observation"];
                                                  NSString *currentTemp = [currentObservation objectForKey:@"temperature_string"];
                                                  
                                                  //Get current temperature string
                                                  NSString *printString = @"Current Temp: ";
                                                  printString = [printString stringByAppendingString:currentTemp];
                                                  
                                                  //Get current weather string and append to temp
                                                  NSString *weatherString = [currentObservation objectForKey:@"weather"];
                                                  printString = [printString stringByAppendingString:@"\n"];
                                                  printString = [printString stringByAppendingString:weatherString];
                                                  
                                                  //Get currrent wind string and append to above
                                                  NSString *windString = [currentObservation objectForKey:@"wind_string"];
                                                  printString = [printString stringByAppendingString:@"\n"];
                                                  printString = [printString stringByAppendingString:windString];
                                                  
                                                  //Get forecast for the rest of today
                                                  NSDictionary *forecast = [json objectForKey:@"forecast"];
                                                  NSDictionary *textForecast = [forecast objectForKey:@"txt_forecast"];
                                                  NSArray *forecastDay = [textForecast objectForKey:@"forecastday"];
                                                  
                                                  //Get today's forecast
                                                  NSDictionary *todayForecast = [forecastDay objectAtIndex:0];
                                                  NSString *todayForecastText = [todayForecast objectForKey:@"fcttext"];
                                                  //printString = [printString stringByAppendingString:@"\n"];
                                                  printString = [printString stringByAppendingString:@"\n"];
                                                  printString = [printString stringByAppendingString:todayForecastText];
                                                  
                                                  //Get tomorrow's forecast (12 hour chunks)
                                                  NSDictionary *tomorrowForecast = [forecastDay objectAtIndex:2];
                                                  NSString *tomorrowForecastText = [tomorrowForecast objectForKey:@"fcttext"];
                                                  //printString = [printString stringByAppendingString:@"\n"];
                                                  printString = [printString stringByAppendingString:@"\n"];
                                                  printString = [printString stringByAppendingString:tomorrowForecastText];
                                                  
                                                  
                                                  NSLog(@"%@",forecastDay);
                                                  
                                                  //NSLog(@"Data = %@",json);
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      self.WeatherTextView.text = printString;
                                                  });
                                              }
                                              else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      self.WeatherTextView.text = @"error";
                                                  });
                                              }
                                          }];
    
    // 3
    self.WeatherTextView.text = @"Get Weather\n";
    [downloadTask resume];
}




@end
