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
    [self saveInfoToDB];
}

- (void) saveInfoToDB {
    
    PFObject *myUserRow = [PFObject objectWithClassName:@"UserLocations"];
    myUserRow[@"lat"] = [[NSNumber alloc] initWithFloat: self.locationManager.location.coordinate.latitude];
    myUserRow[@"lon"] = [[NSNumber alloc] initWithFloat: self.locationManager.location.coordinate.longitude];
    myUserRow[@"userid"] = [[NSNumber alloc] initWithInt:userid];
    myUserRow[@"currentTimeStamp"] = [self timeStamp];
    [myUserRow saveInBackground];
    NSLog(@"Saved your info to database.");
}

- (NSString *) timeStamp {
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
}

- (void) enteredBackground{
//    PFQuery *query = [PFQuery queryWithClassName:@"UserLocations"];
//    [query getObjectInBackgroundWithId:@"7FdiuU5EUG" block:^(PFObject *gameScore, NSError *error) {
//        // Do something with the returned PFObject in the gameScore variable.
//        NSLog(@"%@", gameScore);
//    }];
    
//    NSLog(@"1");
//    PFQuery *query = [PFQuery queryWithClassName:@"UserLocations"];
//    NSLog(@"2");
//    [query whereKey:@"userid" equalTo:[[NSNumber alloc] initWithInt:userid]];
//    NSLog(@"3");
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        NSLog(@"4");
//        if (!error) {
//            // The find succeeded.
//            NSLog(@"Successfully retrieved %d scores.", objects.count);
//            // Do something with the found objects
//            for (PFObject *object in objects) {
//                NSLog(@"%@", object.objectId);
//                [object deleteInBackground];
//            }
//        } else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
//    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//        NSLog(@"4");
//        if (!object) {
//            NSLog(@"The getFirstObject request failed.");
//        } else {
//            // The find succeeded.
//            NSLog(@"Successfully retrieved the object.");
//            [object deleteInBackground];
//        }
//    }];
    
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
