//
//  ThirdViewController.m
//  House Hardy
//
//  Created by Joseph Hardy on 7/31/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import "ThirdViewController.h"

@implementation ThirdViewController
- (IBAction)spotifyButton:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString:
      @"spotify://http://open.spotify.com/"]];
}

- (IBAction)archiveButton:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString:
      @"googlechrome://www.archive.org/details/GratefulDead"]];

}

@end
