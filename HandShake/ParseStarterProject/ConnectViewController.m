//
//  ConnectViewController.m
//  ParseStarterProject
//
//  Created by Albert Chu on 9/14/14.
//
//

#import "ConnectViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@interface ConnectViewController ()

@property (nonatomic, strong) NSData * extract;
@property (nonatomic, strong) NSDictionary * JSON;

@end

@implementation ConnectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    //NSURLConnection * urlconn = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://graph.facebook.com/1451275742"]] delegate:self];
    ABPeoplePickerNavigationController *peoplePicker=[[ABPeoplePickerNavigationController alloc] init];
    ABAddressBookRef addressBook = [peoplePicker addressBook];
    
    // create person record
    
    ABRecordRef person = ABPersonCreate();
    // set name and other string values
    
    
    NSString *firstName=@"Chintav";
    NSString *lastName=@"Shah";
    NSString *phoneNo=@"7326758035";
    
    
    CFErrorRef cfError=nil;
    
    if (firstName) {
        ABRecordSetValue(person, kABPersonFirstNameProperty, (__bridge CFTypeRef)(firstName) , nil);
    }
    
    if (lastName) {
        ABRecordSetValue(person, kABPersonLastNameProperty, (__bridge CFTypeRef)(lastName) , nil);
    }
    
    if (phoneNo)
    {
        ABMutableMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        NSArray *venuePhoneNumbers = [phoneNo componentsSeparatedByString:@" or "];
        for (NSString *venuePhoneNumberString in venuePhoneNumbers)
            ABMultiValueAddValueAndLabel(phoneNumberMultiValue, (__bridge CFStringRef) venuePhoneNumberString, kABPersonPhoneMainLabel, NULL);
        ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, nil);
        CFRelease(phoneNumberMultiValue);
    }
    
    
    //Add person Object to addressbook Object.
    ABAddressBookAddRecord(addressBook, person, &cfError);
    
    if (ABAddressBookSave(addressBook, nil)) {
        NSLog(@"\nPerson Saved successfuly");
    } else {
        NSLog(@"\n Error Saving person to AddressBook");
    }
    // Do any additional setup after loading the view.
    [self jumpToFacebook:@"1451275742"];
    
}

-(void)jumpToFacebook:(NSString *)facebookID
{
    //NSString *userName = [self.JSON objectForKey:@"username"];
    //NSString *fburl = [@"fb://profile/" stringByAppendingString:facebookID];
    //NSString *safariurl = [@"http://facebook.com/" stringByAppendingString:userName];
    //NSURL *urlApp = [NSURL URLWithString:fburl];
    NSURL *urlApp = [NSURL URLWithString: @"fb://profile/1451275742"];
    NSString *safariurl = @"http://facebook.com/chintav.shah1";
    if ([[UIApplication sharedApplication] canOpenURL:urlApp]) {
        NSLog(@"Can open");
        [[UIApplication sharedApplication] openURL:urlApp];
    } else {
        NSLog(@"cannot open");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:safariurl]];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
