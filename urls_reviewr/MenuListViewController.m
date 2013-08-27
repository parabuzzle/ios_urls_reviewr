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
    NSLog([NSString stringWithFormat:@"Menu object: %@", self.selectedBuidling]);
    
    [self loadMenuData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (id)initWithName:(NSString *)theName{
    self = [super initWithNibName:@"MenuListViewController" bundle:nil];
    if (self) {
        self.selectedBuidling = [theName copy];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[self.menuArray objectAtIndex:indexPath.row] title];
    cell.shouldIndentWhileEditing = YES;
    
    return cell;
}

#pragma mark - Private methods

- (void)loadMenuData{
    
    //Load data from backend server
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[[NSURL alloc]initWithString:@"http://api.reviewr.mail.vip.gq1.yahoo.net/today.json"]];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        [self convertMenuJsonToArray:JSON];
        [self.tableView reloadData];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Failed ==========\n%@ %@", error, JSON);
    }];
    
    [operation start];

    
    
    // Load data from backend use NSString value self.selectedBuilding
    // to get a custom menu data.
    //self.menuArray = [[NSMutableArray alloc] initWithObjects:@"Item 1", @"Item 2", @"Item 3", nil];
    
}

- (void)convertMenuJsonToArray:(id)JSON{
    
    NSDictionary *current;
    NSDictionary *menu;
    
    self.menuArray = [[NSMutableArray alloc] initWithCapacity:[JSON count]];
    for (int i=0; i < [JSON count]; i++) {
        current = [JSON objectAtIndex:i];
        
        menu = [current objectForKey:self.selectedBuidling];
        
        if(menu){
            //[self.menuArray addObject:[menu objectForKey:@""]];
            NSLog(@"------------\n\n%@", [menu objectForKey:@"breakfast"]);
            [self addMealTimeMenu:@"breakfast" withMenu:menu];
            [self addMealTimeMenu:@"lunch" withMenu:menu];
            [self addMealTimeMenu:@"dinner" withMenu:menu];
        }
        
    }
    
}

- (void)addMealTimeMenu:(NSString *)mealtime withMenu:(NSDictionary *)menuDictionary{
    
    NSDictionary *current = [menuDictionary objectForKey:mealtime];
    NSArray *menus = [current objectForKey:@"menus"];
    Menu *menu;
    
    for(int i=0; i < menus.count; i++){
        menu = [Menu fromJSON:[menus objectAtIndex:i]];
        for (int i = 0; i < menu.menuItems.count; i++) {
            [self.menuArray addObject:[menu.menuItems objectAtIndex:i]];
        }
    }
    
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    MenuItemViewController *menuViewController = [[MenuItemViewController alloc] initWithName:[self.menuArray objectAtIndex:indexPath.row]];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:menuViewController animated:YES];
}

@end
