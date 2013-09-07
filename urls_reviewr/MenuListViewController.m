//
//  MenuListViewController.m
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "MenuListViewController.h"
#import "MenuItemViewController.h"
#import "AFJSONRequestOperation.h"
#import "AFNetworking.h"
#import "MenuItem.h"
#import "UrlsClient.h"
#import "MenuItemCell.h"
#import "BuildingListViewController.h"
#import "MenusDocument.h"
#import "MMProgressHUD.h"
#import "MMProgressHUDOverlayView.h"

@interface MenuListViewController ()

@property (nonatomic, strong) NSMutableArray *menuArray;

- (void)loadMenuData;

@end

@implementation MenuListViewController

@synthesize menuItemCell = _menuItemCell;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Menu";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.selectedBuidling;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadMenuData];
}

- (id)initWithName:(NSString *)theName {
    self = [super initWithNibName:@"MenuListViewController" bundle:nil];
    if (self) {
        self.menusDocument = [MenusDocument instance];
        self.selectedBuidling = [theName copy];
        
        UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadBuildingData)];
        self.navigationItem.rightBarButtonItem = refreshButton;
        // Custom Background for Each Building
        NSString *image_name = @"peppers-clear.png";
        if ([self.selectedBuidling isEqual: @"Url's Cafe"]) {
            image_name = @"bldg-urls-clear-tall.png";
        } else if ([self.selectedBuidling isEqual: @"Bldg E"]){
            image_name = @"bldg-e-clear-tall.png";
        } else if ([self.selectedBuidling isEqual: @"Bldg F"]){
            image_name = @"bldg-f-clear-tall.png";
        } else if ([self.selectedBuidling isEqual:@"Bldg G"]) {
            image_name = @"bldg-g-clear-tall.png";
        } else if ([self.selectedBuidling isEqual: @"Boardwalk Cafe"]){
            // Where the hell is Boardwalk Cafe?!
            image_name = @"peppers-clear.png";
        }
        UIImage *backgroundImage = [UIImage imageNamed:image_name];
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        [backgroundView setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
        [backgroundView setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin];
        self.tableView.backgroundView = backgroundView;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.menuArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Section %d count: %d", section, [[[self.menuArray objectAtIndex:section] menuItems] count]);
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            //NSLog(@"Section %d count: %d", section, [[[self.menuArray objectAtIndex:section] menuItems] count]);
            return [[[self.menuArray objectAtIndex:section] menuItems] count];
            break;
        case 1:
            return [[[self.menuArray objectAtIndex:section] menuItems] count];
            break;
        case 2:
            return [[[self.menuArray objectAtIndex:section] menuItems] count];
            break;
        default:
            break;
    }
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MenuItemCell *cell = (MenuItemCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (MenuItemCell *) [[NSBundle mainBundle] loadNibNamed:@"MenuItemCell" owner:self options:nil];
        cell = _menuItemCell;
    }
    
    // Configure the cell...
    Menu *currentMenu = [self.menuArray objectAtIndex:indexPath.section];
    MenuItem *selectedMenuItem = [currentMenu.menuItems objectAtIndex:indexPath.row];
    cell.menuItemTitleLabel.text = [[selectedMenuItem title] capitalizedString];
    
    cell.backgroundColor = [UIColor clearColor];
    //cell.backgroundView.alpha = 0.30;
    cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, 100);

    cell.menuItemTitleLabel.textColor = [UIColor whiteColor];
    cell.menuItemTitleLabel.font = [UIFont boldSystemFontOfSize:14];
    //cell.menuItemTitleLabel.textAlignment = UITextAlignmentLeft;
    cell.reviewsLabel.textColor = [UIColor whiteColor];
    cell.reviewsLabel.font = [UIFont boldSystemFontOfSize:12];
    cell.reviewsLabel.text = [NSString stringWithFormat:@"%d reviews", selectedMenuItem.reviewers];
    cell.ratingImage.image = [UIImage imageNamed:[selectedMenuItem ratingImageNameinWhite]];
    cell.ratingLabel.textColor = [UIColor whiteColor];
    cell.ratingLabel.font = [UIFont boldSystemFontOfSize:12];
    cell.ratingLabel.text = [NSString stringWithFormat:@"%@/5", [selectedMenuItem stringFormattedRating]];
    cell.shouldIndentWhileEditing = YES;
    UIView *selectedBackgroundViewForCell = [UIView new];
    [selectedBackgroundViewForCell setBackgroundColor:[UIColor purpleColor]];
    cell.selectedBackgroundView = selectedBackgroundViewForCell;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

#pragma mark - Private methods

- (void)loadMenuData{
    
    //Load data from backend server
    //[[UrlsClient instance] todaysMenu:^(AFHTTPRequestOperation *operation, id response) {
    
        //NSLog(@"%@", response);
        //[self convertMenuJsonToArray:response];
    
    //} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //    NSLog(@"Failed ==========\n%@", error);
    //}];
    [self convertMenuJsonToArray:self.menusDocument.document];
    [self.tableView reloadData];
    
}

- (void)loadBuildingData {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:@"Please Wait" status:@"Refreshing Data"];
    //Load data from backend server
    [[UrlsClient instance] buildingList:^(AFHTTPRequestOperation *operation, id response) {
        [self convertMenuJsonToArray:response];
        self.menusDocument.document = response;
        
        // This is a dirty way of getting the newest menu if there isn't a menu for "Today"
        if (self.menusDocument.document.count == 0) {
            [[UrlsClient instance] menuDates:^(AFHTTPRequestOperation *operation, id response) {
                [[UrlsClient instance] buildingListForDate:response[0] success:^(AFHTTPRequestOperation *operation, id json) {
                    [self convertMenuJsonToArray:json];
                    self.menusDocument.document = json;
                    [[[UIAlertView alloc] initWithTitle:@"Today's Menu Not Found" message:[NSString stringWithFormat:@"There was no menu found for today. We have loaded the menu from %@", response[0]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                    [self.tableView reloadData];
                }failure:^(AFHTTPRequestOperation *operation, NSError *error) {}];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {}];
        }
        
        [self.tableView reloadData];
        [MMProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed ==========\n%@", error);
        [MMProgressHUD dismissWithError:[NSString stringWithFormat:@"Error fetching from server, please try again later.\ncode=%d", error.code] title:@"Error" afterDelay:3];
    }];
}


- (void)convertMenuJsonToArray:(id)JSON{
    
    NSDictionary *current;
    NSDictionary *menu;
    
    self.menuArray = [[NSMutableArray alloc] initWithCapacity:3];
    for (int i=0; i < [JSON count]; i++) {
        current = [JSON objectAtIndex:i];
        
        menu = [current objectForKey:self.selectedBuidling];
        
        if(menu){
            [self addMealTimeMenu:@"breakfast" withMenu:menu withIndex:0];
            [self addMealTimeMenu:@"lunch" withMenu:menu withIndex:1];
            [self addMealTimeMenu:@"dinner" withMenu:menu withIndex:2];
        }
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    titleLabel.textColor = [UIColor greenColor];
    titleLabel.backgroundColor = [UIColor blackColor];
    titleLabel.alpha = 0.8;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    switch (section) {
        case 0:
            titleLabel.text = @"Breakfast";
            break;
        case 1:
            titleLabel.text = @"Lunch";
            break;
        case 2:
            titleLabel.text = @"Dinner";
            break;
        default:
            break;
    }
    
    [headerView addSubview:titleLabel];
    
    return headerView;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)addMealTimeMenu:(NSString *)mealtime withMenu:(NSDictionary *)menuDictionary withIndex:(NSInteger)index{
    
    NSDictionary *menus = [menuDictionary objectForKey:mealtime];
    
    if(menus){
        Menu *menu = [Menu fromJSON:menus];
        [self.menuArray insertObject:menu atIndex:index];
    } else {
       [self.menuArray insertObject:[[Menu alloc] init] atIndex:index];
    }
    
    
    
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    Menu *selectedMenu = [self.menuArray objectAtIndex:indexPath.section];
    MenuItemViewController *menuViewController = [[MenuItemViewController alloc] initWithName:[selectedMenu.menuItems objectAtIndex:indexPath.row]];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:menuViewController animated:YES];
}

@end
