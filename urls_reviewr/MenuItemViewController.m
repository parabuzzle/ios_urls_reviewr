//
//  MenuItemViewController.m
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "MenuItemViewController.h"
#import "MenuItem.h"

@interface MenuItemViewController ()

- (MenuItem *)loadMenuItemWithName:(NSString *)theName;

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

- (id)initWithName:(NSString *)menuItemName{
    self = [super initWithNibName:@"MenuItemViewController" bundle:nil];
    if (self) {
        self.selectedMenuItem = [menuItemName copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title = self.selectedMenuItem;
    NSLog([NSString stringWithFormat:@"Menu object: %@", self.selectedMenuItem]);
    
    [self loadMenuItemData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)loadMenuItemData{
    
    // Load data from backend use NSString value self.selectedBuilding
    // to get a custom menu data.
    MenuItem *menuItem = [self loadMenuItemWithName:@"Menu Item"];
    
    self.menuItemDescription.text = menuItem.description;
    self.menuItemName.text = menuItem.name;
    self.menuItemRating.text = menuItem.ratings;
    self.numberOfComments.text = menuItem.numberOfComments;
    
}

- (MenuItem *)loadMenuItemWithName:(NSString *)theName{
    
    #warning Implement loading of Menu Item from API
    MenuItem *menuItem = [[MenuItem alloc] init];
    menuItem.name = @"Menu Item Name";
    menuItem.description = @"Menu Item Description";
    menuItem.ratings = @"4/5";
    menuItem.commentsList = [[NSMutableArray alloc] initWithObjects:@"Comment 1", @"Comment 2", @"Comment 3", nil];
    menuItem.numberOfComments = [NSString stringWithFormat:@"Menu object: %d", menuItem.commentsList.count];
    
    return menuItem;
}

@end
