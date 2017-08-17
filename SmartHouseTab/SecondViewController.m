//
//  SecondViewController.m
//  SmartHouseTab
//
//  Created by Joseph Hardy on 7/10/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedStation = @"DELN";
    _stationPickerData = @[@"12TH",
                        @"16TH",
                        @"19TH",
                        @"24TH",
                        @"ASHB",
                        @"BALB",
                        @"BAYF",
                        @"CAST",
                        @"CIVC",
                        @"COLS",
                        @"COLM",
                        @"CONC",
                        @"DALY",
                        @"DBRK",
                        @"DUBL",
                        @"DELN",
                        @"PLZA",
                        @"EMBR",
                        @"FRMT",
                        @"FTVL",
                        @"GLEN",
                        @"HAYW",
                        @"LAFY",
                        @"LAKE",
                        @"MCAR",
                        @"MLBR",
                        @"MONT",
                        @"NBRK",
                        @"NCON",
                        @"OAKL",
                        @"ORIN",
                        @"PITT",
                        @"PHIL",
                        @"POWL",
                        @"RICH",
                        @"ROCK",
                        @"SBRN",
                        @"SFIA",
                        @"SANL",
                        @"SHAY",
                        @"SSAN",
                        @"UCTY",
                        @"WCRK",
                        @"WDUB",
                        @"WOAK",
                        @"WARM"];
    
 //   _stationURLStrings = @[@"",
 //                          @""];
    
    self.firstPickerView.dataSource = self;
    self.firstPickerView.delegate = self;
    [self initializeBARTViewDataSource];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    // Overwrite preferred status bar style and return ENUM LightContent
    return UIStatusBarStyleLightContent;
}

- (void)initializeBARTViewDataSource
{
    // Set up the weatherArray and set the dataSource for the current
    self.BARTArray = [[NSMutableArray alloc] initWithObjects:@"", nil];
    self.BARTTableView.dataSource = self;
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
    return [self.BARTArray count];
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
    cell.textLabel.text = [self.BARTArray objectAtIndex:row];
    cell.textLabel.font = [UIFont fontWithName: @"Avenir" size:14];
    
    return cell;
}


// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _stationPickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _stationPickerData[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    _selectedStation = _stationPickerData[row];
    NSLog(@"%@",_stationPickerData[row]);
}


- (IBAction)bartHomeButton:(UIButton *)sender {
    
    self.utilitiesTextView.text = @"Get BART Home\n";
    NSString *dataUrl = @"http://api.bart.gov/api/etd.aspx?cmd=etd&orig=";

    dataUrl = [dataUrl stringByAppendingString:_selectedStation];
    dataUrl = [dataUrl stringByAppendingString:@"&dir=n&key=MW9S-E7SL-26DU-VV8V"];

    NSURL *url = [NSURL URLWithString:dataUrl];
    
    //This whole thing should be a method...
    JLHNetworkManager *networkManager = [[JLHNetworkManager alloc] init];
    
    [networkManager getDataWithURL:url success:^(NSData *data) {
        BartTimes *bartTimes = [[BartTimes alloc] initFromData:data];
        NSLog(@"%@",bartTimes.displayTextArray);
        
        self.BARTArray = bartTimes.displayTextArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.BARTTableView reloadData];
        });
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.BARTArray[0] = @"error";
            NSLog(@"%@",error);
        });
    }];
    

    /*
    JLHBartTimes *homeBartTimes = [[JLHBartTimes alloc] init];
    
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
}
/*- (IBAction)bartCivicCenterButton:(UIButton *)sender {
    self.utilitiesTextView.text = @"Get BART from 16th St\n";
    
    NSString *dataUrl = @"http://api.bart.gov/api/etd.aspx?cmd=etd&orig=CIVC&dir=n&key=MW9S-E7SL-26DU-VV8V";
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    JLHBartTimes *homeBartTimes = [[JLHBartTimes alloc] init];
    
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
}
*/
- (IBAction)bartWorkButton:(UIButton *)sender {
    
    self.utilitiesTextView.text = @"Get BART from El Cerrito del Norte\n";
    
    NSString *dataUrl = @"http://api.bart.gov/api/etd.aspx?cmd=etd&orig=deln&dir=s&key=MW9S-E7SL-26DU-VV8V";
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    JLHNetworkManager *networkManager = [[JLHNetworkManager alloc] init];
    
    [networkManager getDataWithURL:url success:^(NSData *data) {
        BartTimes *bartTimes = [[BartTimes alloc] initFromData:data];
        NSLog(@"%@",bartTimes.displayTextArray);
        
        self.BARTArray = bartTimes.displayTextArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.BARTTableView reloadData];
        });

    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.BARTArray[0] = @"error";
            NSLog(@"%@",error);
        });
    }];

}

@end
