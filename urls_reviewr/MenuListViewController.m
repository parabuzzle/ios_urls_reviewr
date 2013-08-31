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

@interface MenuListViewController ()

@property (nonatomic, strong) NSMutableArray *menuArray;

- (void)loadMenuData;

@end

@implementation MenuListViewController

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
    [self loadMenuData];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (id)initWithName:(NSString *)theName{
    self = [super initWithNibName:@"MenuListViewController" bundle:nil];
    if (self) {
        self.selectedBuidling = [theName copy];
        
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.numberOfLines = 0;
    Menu *tempMenu = [self.menuArray objectAtIndex:indexPath.section];
    
    cell.textLabel.text = [[[tempMenu.menuItems objectAtIndex:indexPath.row] title] capitalizedString];
    [cell sizeToFit];
    cell.backgroundColor = [UIColor blackColor];
    cell.backgroundView.alpha = 0.30;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.shouldIndentWhileEditing = YES;
    UIView *selectedBackgroundViewForCell = [UIView new];
    [selectedBackgroundViewForCell setBackgroundColor:[UIColor purpleColor]];
    cell.selectedBackgroundView = selectedBackgroundViewForCell;
    return cell;
}

#pragma mark - Private methods

- (void)loadMenuData{
    
    //Load data from backend server
    [[UrlsClient instance] todaysMenu:^(AFHTTPRequestOperation *operation, id response) {
    
        NSLog(@"%@", response);
        [self convertMenuJsonToArray:response];
        [self.tableView reloadData];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed ==========\n%@", error);
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
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
    titleLabel.textColor = [UIColor greenColor];
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
