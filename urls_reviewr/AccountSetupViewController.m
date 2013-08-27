//
//  AccountSetupViewController.m
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "AccountSetupViewController.h"
#import "User.h"
#import "UrlsClient.h"
#import "AFNetworking.h"

@interface AccountSetupViewController ()

- (void) onSaveUser;

@end

@implementation AccountSetupViewController

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
    // Give focus to the username field and load the keyboard
    [self.username becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSaveButton:(id)sender {
    // Send the username to the server and capture the token, userid, and token
    if ([self.username.text  isEqual: @""]) {
        // Looks like the user didn't enter a username.. throw a dialog!
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Username" message:@"You must enter a username" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        NSLog(@"Missing Username");
        
    } else {
        // Verify the user wants this user
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Verify Email" message:[NSString stringWithFormat:@"An email will be sent to %@@yahoo-inc.com with verification information. Is this username correct?", self.username.text] delegate:self cancelButtonTitle:@"No, Let Me Edit" otherButtonTitles:@"Save and Send", nil];
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // When the user dismisses the alert view... save
    if (buttonIndex == 1) {
        // User has verified their username
        // Save the user...
        [self onSaveUser];
        
        // Dismiss view
        
    }
    // User didn't verify.. Do nothing
    
}


#pragma mark - Private Methods

- (void) onSaveUser {
    // init the user object
    //User *myUserObj = [[User alloc] initWithUsername:self.username.text];
    
    
    [[UrlsClient instance] userInit:self.username.text success:^(AFHTTPRequestOperation *operation, id response) {
        User *user = [[User alloc] initWithDictionary:response];
        [user saveLocal];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // do nothing for now..
    }];
}

@end
