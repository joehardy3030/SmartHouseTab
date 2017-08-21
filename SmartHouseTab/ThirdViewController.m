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
                        @"Eagles Auditorium 1968-01-22",
                        @"Boston Tea Party 1969-12-31",
                        @"Alfred College 1970-05-01",
                        @"Pauley Pavilion 1971-11-20",
                        @"Hill Auditorium 1971-12-14",
                        @"Academy of Music 1972-03-23",
                        @"Berkeley 1972-08-25",
                        @"Kezar Stadium 1973-05-26",
                        @"Dillon Stadium 1974-07-31",
                        @"Great American 1975-08-13",
                        @"Beacon Theatre 1976-06-14",
                        @"Cornell 1977-05-08",
                        @"Buffalo 1977-05-09",
                        @"Nashville 1978-12-16",
                        @"Oakland Colesium 1979-02-17",
                        @"Cumberland County 1980-05-11",
                        @"Uptown Theater 1981-02-27",
                        @"U. of Iowa 1982-08-10",
                        @"Olympic Arena 1983-10-17",
                        @"Augusta 1984-10-12",
                        @"Saratoga 1985-96-27",
                        @"Oakland-Alameda 1986-12-15",
                        @"The Spectrum 1987-09-24",
                        @"Oxford Plains 1988-07-02",
                        @"Oxford Plains 1988-07-03",
                        @"Giants Stadium 1989-07-09",
                        @"Nassau Colesium 1990-03-29",
                        @"MSG 1991-09-10",
                        @"Sam Boyd 1992-05-31",
                        @"Autzen Stadium UO 1993-08-22",
                        @"Boston Garden 1994-10-01",
                        @"Soldier Field 1995-07-09"];
    
    _showURLStrings = @[@"archive.org/details/gd1966-07-16.sbd.miller.89555.sbeok.flac16",
                        @"archive.org/details/gd1968-01-22.sbd.miller.97342.sbeok.flac16",
                        @"archive.org/details/gd1969-12-31.sbd.miller.95420.sbeok.flac16",
                        @"archive.org/details/gd1970-05-01.sbd.miller.95683.sbeok.flac16",
                        @"archive.org/details/gd1971-11-20.sbd.miller.92908.sbeok.flac16",
                        @"archive.org/details/gd71-12-14.sbd.deibert.12763.sbeok.shnf",
                        @"archive.org/details/gd1972-03-23.sbd.miller.100000.sbeok.flac16",
                        @"archive.org/details/gd1972-08-25.sbd.miller.92840.sbeok.flac16",
                        @"archive.org/details/gd1973-05-26.sbd.miller.patched.83535.flac16",
                        @"archive.org/details/gd1974-07-31.sbd.miller.32353.sbeok.flac16",
                        @"archive.org/details/gd1975-08-13.fm.cousinit.18512.sbeok.shnf",
                        @"archive.org/details/gd76-06-14.sbd.hollister.22804.sbeok.shnf",
                        @"archive.org/details/gd77-05-08.sbd.hicks.4982.sbeok.shnf",
                        @"archive.org/details/gd77-05-09.sbd.connor.8304.sbeok.shnf",
                        @"archive.org/details/gd1978-12-16.sonyecm250-no-dolby.walker-scotton.miller.82212.sbeok.flac16",
                        @"archive.org/details/gd1979-02-17.sbd.scotton-miller.88123.flac16",
                        @"archive.org/details/gd1980-05-11.nak300.friend.andrewf.107227.flac16",
                        @"archive.org/details/gd1981-02-27.mtx.chappell.sb02b.28384.sbeok.flac16",
                        @"archive.org/details/gd82-08-10.sbd.miller.12453.sbeok.shnf",
                        @"archive.org/details/gd1983-10-17.mtx.seamons.fix2.92424.sbeok.flac16",
                        @"archive.org/details/gd1984-10-12.mtx.seamons.117573.flac16",
                        @"archive.org/details/gd85-06-27.sbd.miller.27863.sbeok.flacf",
                        @"archive.org/details/gd86-12-15.nakcm101-dwonk.25263.sbeok.flacf",
                        @"archive.org/details/gd1987-09-24.sbd.miller.fix-92282.92506.flac16",
                        @"archive.org/details/gd1988-07-02.132394.Nak100CP4.Seremetcc.Keo.Flac2496",
                        @"archive.org/details/gd1988-07-03.Nak300CP4.Fitzy.Keo.124855.Flac2496",
                        @"archive.org/details/gd1989-07-09.sbd.miller.81177.sbeok.flac16",
                        @"archive.org/details/gd90-03-29.sbd.nawrocki.3389.sbeok.shnf",
                        @"archive.org/details/gd91-09-10.sbd.sacks.511.sbeok.shnf",
                        @"archive.org/details/gd92-05-31.sbd.paino.544.sbefail.shnf",
                        @"archive.org/details/gd93-08-22.sbd.nawrocki.562.sbefail.shnf",
                        @"archive.org/details/gd94-10-01.sbd.ashley-bertha.14869.sbeok.shnf",
                        @"archive.org/details/gd1995-07-09.sbd.miller.114369.flac16"];

    self.showPickerView.dataSource = self;
    self.showPickerView.delegate = self;
    self.textView.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
   
    [self.view addGestureRecognizer:tap];
    
}

-(void)dismissKeyboard
{
    [self.textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // Overwrite preferred status bar style and return ENUM LightContent
    return UIStatusBarStyleLightContent;
}

// Close the keyboard when the user touches the view outside the keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
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

/*- (IBAction)spotifyButton:(UIButton *)sender {
    
    NSDictionary *optionsDict;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"spotify://http://open.spotify.com/"]
                                       options:optionsDict
                             completionHandler: ^(BOOL success){
                                 // 4: Handle response here
                                 if(success == true)
                                 {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         self.textView.text = @"Opened Spotify";
                                     });
                                 }
                                 else{
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         self.textView.text = @"error";
                                     });
                                 }
                             }];

}
*/

- (IBAction)archiveButton:(UIButton *)sender {

    NSDictionary *optionsDict;
    NSString *urlString = @"googlechrome://";
    urlString = [urlString stringByAppendingString:_selectedShow];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]
                                       options:optionsDict
                             completionHandler: ^(BOOL success){
                                 // 4: Handle response here
                                 if(success == true)
                                 {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         self.textView.text = _selectedShow;
                                     });
                                 }
                                 else{
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         self.textView.text = @"error";
                                     });
                                 }
                             }];

}


- (IBAction)stereoOnButton:(UIButton *)sender {
//    NSString *dataUrl = @"http://10.0.0.11/arduino/outletOn";
    NSString *dataUrl = UPSTAIRS_ARDUINO;
    dataUrl = [dataUrl stringByAppendingString:@"/arduino/outletOn"];
    

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
  
    NSString *dataUrl = UPSTAIRS_ARDUINO;
    dataUrl = [dataUrl stringByAppendingString:@"/arduino/outletOff"];

//    NSString *dataUrl = @"http://10.0.0.11/arduino/outletOff";
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
