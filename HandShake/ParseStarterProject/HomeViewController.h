//
//  ParseStarterProjectViewController.h
//  ParseStarterProject
//
//  Copyright 2014 Parse, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "HomeViewController.h"
#import <Parse/Parse.h>

@interface HomeViewController : UIViewController <CLLocationManagerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate> {
    BOOL haveLocationNotLoggedIn;
}
-(void) enteredBackground;
-(void) saveInfoToDB;
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic) PFObject *myUserRow;

@end
