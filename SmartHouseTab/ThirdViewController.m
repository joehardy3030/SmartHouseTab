//
//  ThirdViewController.m
//  House Hardy
//
//  Created by Joseph Hardy on 7/31/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedShow = @"archive.org/details/gd77-05-08.sbd.hicks.4982.sbeok.shnf";
    _showPickerData = @[@"Fillmore 1966-07-16",
                        @"Academy of Music 1972-03-23",
                        @"Kezar Stadium 1973-05-26",
                        @"Dillon Stadium 1974-07-31",
                        @"Cornell 1977-05-08",
                        @"Buffalo 1977-05-09",
                        @"Augusta 1984-10-12",
                        @"Oxford Plains 1988-07-02",
                        @"Oxford Plains 1988-07-03",
                        @"Soldier Fiedl 1995-07-09"];
    
    _showURLStrings = @[@"archive.org/details/gd1966-07-16.sbd.miller.89555.sbeok.flac16",
                        @"archive.org/details/gd1972-03-23.sbd.miller.100000.sbeok.flac16",
                        @"archive.org/details/gd1973-05-26.sbd.miller.patched.83535.flac16",
                        @"archive.org/details/gd1974-07-31.sbd.miller.32353.sbeok.flac16",
                        @"archive.org/details/gd77-05-08.sbd.hicks.4982.sbeok.shnf",
                        @"archive.org/details/gd77-05-09.sbd.connor.8304.sbeok.shnf",
                        @"archive.org/details/gd1984-10-12.mtx.seamons.117573.flac16",
                        @"archive.org/details/gd1988-07-02.132394.Nak100CP4.Seremetcc.Keo.Flac2496",
                        @"archive.org/details/gd1988-07-03.Nak300CP4.Fitzy.Keo.124855.Flac2496",
                        @"archive.org/details/gd1995-07-09.sbd.miller.114369.flac16"];

    self.showPickerView.dataSource = self;
    self.showPickerView.delegate = self;
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _showPickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _showPickerData[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    _selectedShow = _showURLStrings[row];
    NSLog(@"%@",_showPickerData[row]);
}

- (IBAction)spotifyButton:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString:
      @"spotify://http://open.spotify.com/"]];
}

- (IBAction)archiveButton:(UIButton *)sender {
    NSString *urlString = @"googlechrome://";
    urlString = [urlString stringByAppendingString:_selectedShow];
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString:urlString]];

}

- (IBAction)notificationButton:(UIButton *)sender {
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = @"Notification set";
    note.fireDate = [NSDate date];
    note.fireDate = [note.fireDate dateByAddingTimeInterval:15];

    [[UIApplication sharedApplication] scheduleLocalNotification:note];
    NSLog(@"%@",note);
}

- (IBAction)stereoOnButton:(UIButton *)sender {
    NSString *dataUrl = @"http://10.0.0.11/arduino/outletOn";
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    // 2
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              // 4: Handle response here
                                              if(error == nil)
                                              {
                                                  NSString *text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                  NSLog(@"Data = %@",text);
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      self.textView.text = text;
                                                  });
                                              }
                                              else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      self.textView.text = @"error";
                                                  });
                                              }
                                          }];
    
    // 3
    self.textView.text = @"Stereo On";
    [downloadTask resume];

    
}

- (IBAction)stereoOffButton:(UIButton *)sender {
    NSString *dataUrl = @"http://10.0.0.11/arduino/outletOff";
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    // 2
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              // 4: Handle response here
                                              if(error == nil)
                                              {
                                                  NSString *text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                  NSLog(@"Data = %@",text);
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      self.textView.text = text;
                                                  });
                                              }
                                              else{
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      self.textView.text = @"error";
                                                  });
                                              }
                                          }];
    
    // 3
    self.textView.text = @"Stereo Off";
    [downloadTask resume];
}


@end
