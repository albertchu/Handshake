//
//  MyLogInViewController.m
//  ParseStarterProject
//
//  Created by Hunter Horsley on 9/14/14.
//
//

#import "MyLogInViewController.h"

@interface MyLogInViewController ()

@end

@implementation MyLogInViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HandshakeLogo.png"]]];
    [self.logInView setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0]];
    [self.logInView.passwordField setTextColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0]];
    [self.logInView.usernameField setTextColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0]];

    
}




@end
