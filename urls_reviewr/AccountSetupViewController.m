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
    // register delegates
    self.username.delegate = self;
    
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Email" message:@"You must enter an Email Address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        // Verify the user wants this user
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Verify Email" message:[NSString stringWithFormat:@"An email will be sent to %@ with verification information. Is this email correct?", self.username.text] delegate:self cancelButtonTitle:@"No, Let Me Edit" otherButtonTitles:@"Yes", nil];
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // When the user dismisses the alert view... save
    if (buttonIndex == 1) {
        // User has verified their username, Save the user to the server and locally
        [self onSaveUser];
    }
    // User chose to edit their username
}

#pragma mark - UITextFieldDelegate methods


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self onSaveButton:textField];
    return YES;
}


#pragma mark - Private Methods

- (void) onSaveUser
{
    // Initalize User object from successful response and close the modal view... or inform the user something went wrong.
    [[UrlsClient instance] userInit:self.username.text success:^(AFHTTPRequestOperation *operation, id response) {
        User *user = [[User alloc] initWithDictionary:response];
        [user saveLocal];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // The request was a failure.. :(
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something Went Wrong" message:@"Something went wrong on the server side, please try your request again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}


@end
