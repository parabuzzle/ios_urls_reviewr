//
//  AddRatingViewController.m
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "AddRatingViewController.h"
#import "UrlsClient.h"
#import "MenuItem.h"

@interface AddRatingViewController ()

@property (nonatomic, strong) MenuItem *menuItem;

@end

@implementation AddRatingViewController

- (id)initWithMenuItem:(MenuItem *)menuItem {
    self = [super init];
    self.menuItem = menuItem;
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)onCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onSaveButton:(id)sender {
    
    Comment *comment = [[Comment alloc] init];
    comment.text = self.textView.text;
    comment.menuItemId = [NSString stringWithFormat:@"%d", self.menuItem.menuItemId];
    NSString *rating = @"5";
    
    NSLog(@"Before calling post");
    [[UrlsClient instance] postCommentsForMenuItem:comment withRating:rating success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"Posting menu item");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog([NSString stringWithFormat:@"Failed to post menu item\nError: %@", error]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something Went Wrong" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
