//
//  ParseStarterProjectViewController.m
//  ParseStarterProject
//
//  Copyright 2014 Parse, Inc. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "MyLogInViewController.h"
#import "MySignUpViewController.h"

@implementation HomeViewController 

#pragma mark - UIViewController


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self presentLogInViewController];
}

- (void)presentLogInViewController
{
    if (![PFUser currentUser])
    {
        MyLogInViewController *loginViewController = [MyLogInViewController new];
        loginViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton;
        loginViewController.delegate = self;
        loginViewController.signUpController.delegate = self;
        
        MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
        signUpViewController.delegate = self;
        signUpViewController.fields = PFSignUpFieldsDefault | PFSignUpFieldsAdditional;
        loginViewController.signUpController = signUpViewController;
        
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
    
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    haveLocationNotLoggedIn = NO;
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // best possible accuracy
    [self.locationManager startUpdatingLocation];
    self.myUserRow = [PFObject objectWithClassName:@"UserLocations"];
    
}

- (void) saveInfoToDB {
    PFUser *user = [PFUser currentUser];

    self.myUserRow[@"appIsOpenNow"] = [NSNumber numberWithBool: YES];
    
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:self.locationManager.location.coordinate.latitude
                                                  longitude:self.locationManager.location.coordinate.longitude];
    [self.myUserRow setObject:geoPoint forKey:@"location"];
    //    self.myUserRow[@"userid"] = [[NSNumber alloc] initWithInt:userid];
    self.myUserRow[@"user"] = user;
    self.myUserRow[@"currentTimeStamp"] = [self timeStamp];
    [self.myUserRow saveInBackground];
    NSLog(@"timeStamp %@", self.myUserRow[@"currentTimeStamp"]);
    NSLog(@"Saved your info to database.");
    
    [super viewDidLoad];
    
    [PFCloud callFunctionInBackground:@"usersNearbyNow"
                       withParameters:@{@"request" : user}
                                block:^(NSString *result, NSError *error) {
                                    if (!error) {
                                        NSLog(@"%@", result);
                                    }
                                }];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"did fail with error %@", error);
    NSLog(@"%d", [CLLocationManager locationServicesEnabled]);
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if ([PFUser currentUser]) {
        [self saveInfoToDB];
    }
    else {
        haveLocationNotLoggedIn = YES;
    }
    [self.locationManager stopUpdatingLocation];
    
}


- (NSString *) timeStamp {
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
}

- (void) enteredBackground{
    self.myUserRow[@"appIsOpenNow"] = [NSNumber numberWithBool: FALSE];
    [self.myUserRow saveInBackground];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)userDidAuthenticate:(UIViewController *)authController
{
    if (haveLocationNotLoggedIn == YES) {
        [self saveInfoToDB];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        // Update UI with logged in user
        
    }];
}

- (IBAction)logOutButtonPressed:(id)sender
{
    [PFUser logOut];
    [self presentLogInViewController];
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self userDidAuthenticate:logInController];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self userDidAuthenticate:signUpController];
}

@end


//self.myUserRow[@"geoPoint"] = [[NSNumber alloc] initWithFloat: self.locationManager.location.coordinate.latitude];
//self.myUserRow[@"lon"] = [[NSNumber alloc] initWithFloat: self.locationManager.location.coordinate.longitude];
