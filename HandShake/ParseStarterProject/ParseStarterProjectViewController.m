//
//  ParseStarterProjectViewController.m
//  ParseStarterProject
//
//  Copyright 2014 Parse, Inc. All rights reserved.
//

#import "ParseStarterProjectViewController.h"
#import <Parse/Parse.h>

@implementation ParseStarterProjectViewController

#pragma mark - UIViewController
const int userid = 1;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [self.locationManager startUpdatingLocation];
    self.myUserRow = [PFObject objectWithClassName:@"UserLocations"];
    [self saveInfoToDB];
}

- (void) saveInfoToDB {
    self.myUserRow[@"appIsOpenNow"] = [NSNumber numberWithBool: YES];
    self.myUserRow[@"lat"] = [[NSNumber alloc] initWithFloat: self.locationManager.location.coordinate.latitude];
    self.myUserRow[@"lon"] = [[NSNumber alloc] initWithFloat: self.locationManager.location.coordinate.longitude];
    self.myUserRow[@"userid"] = [[NSNumber alloc] initWithInt:userid];
    self.myUserRow[@"currentTimeStamp"] = [self timeStamp];
    [self.myUserRow saveInBackground];
    NSLog(@"Saved your info to database.");
}

- (NSString *) timeStamp {
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
}

- (void) enteredBackground{
    self.myUserRow[@"appIsOpenNow"] = [NSNumber numberWithBool: FALSE];
    [self.myUserRow saveInBackground];    
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
