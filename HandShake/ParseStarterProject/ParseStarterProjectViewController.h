//
//  ParseStarterProjectViewController.h
//  ParseStarterProject
//
//  Copyright 2014 Parse, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ParseStarterProjectViewController : UIViewController
-(void) enteredBackground;
-(void) saveInfoToDB;
@property (nonatomic,retain) CLLocationManager *locationManager;
@end
