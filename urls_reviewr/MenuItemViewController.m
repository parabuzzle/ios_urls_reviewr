//
//  MenuItemViewController.m
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "MenuItemViewController.h"
#import "MenuItem.h"
#import "UrlsClient.h"

@interface MenuItemViewController ()

@end

@implementation MenuItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithName:(MenuItem *)menuItem{
    self = [super initWithNibName:@"MenuItemViewController" bundle:nil];
    self.menuItem = menuItem;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title = [self.menuItem.title capitalizedString];
    self.menuItemDescription.numberOfLines = 0;
    [self.menuItemDescription sizeToFit];
    
    
    NSLog([NSString stringWithFormat:@"Menu object: %@", self.title]);
    
    [self loadMenuItemData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)loadMenuItemData{
    
    self.menuItemDescription.text = self.menuItem.description;
    self.menuItemName.text = self.menuItem.title;
    self.menuItemRating.text = [NSString stringWithFormat:@"%@/5", self.menuItem.stringFormattedRating];
    self.numberOfComments.text = [NSString stringWithFormat:@"%d reviewers", self.menuItem.reviewers];
    self.ratingsImageView.image = [UIImage imageNamed:self.menuItem.ratingImageName];
    
    [[UrlsClient instance] getCommentsWithMenuItemId:self.menuItem.menuItemId success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"Successfully queried comments for menu item");
        //NSLog(response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to GET comments for menu item");
        //NSLog(error);
    }];
     
}

@end
