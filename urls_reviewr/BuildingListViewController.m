//
//  BuildingListViewController.m
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "BuildingListViewController.h"
#import "MenuListViewController.h"
#import "UrlsClient.h"
#import "Building.h"
#import "MMProgressHUD.h"
#import "MMProgressHUDOverlayView.h"
#import "MenusDocument.h"

@interface BuildingListViewController ()

@property (nonatomic, strong) NSMutableArray *buildings;

@end

@implementation BuildingListViewController

@synthesize menuListViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Cafeterias";
        self.menusDocument = [MenusDocument instance];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBuildingData) name:UIApplicationDidBecomeActiveNotification object:nil];
        
        NSString *image_name = @"background-purple-newlogo.png";
        self.view.clipsToBounds = YES;
        UIImage *backgroundImage = [UIImage imageNamed:image_name];
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        self.tableView.backgroundView = backgroundView;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

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
    return self.buildings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.buildings objectAtIndex:indexPath.row];
    cell.shouldIndentWhileEditing = YES;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    UIView *selectedBackgroundViewForCell = [UIView new];
    [selectedBackgroundViewForCell setBackgroundColor:[UIColor purpleColor]];
    cell.selectedBackgroundView = selectedBackgroundViewForCell;
    return cell;
}

#pragma mark - Private methods

- (void)loadBuildingData {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:@"Please Wait" status:@"Loading Menus"];
    //Load data from backend server
    [[UrlsClient instance] buildingList:^(AFHTTPRequestOperation *operation, id response) {
        [self convertJsonToArray:response];
        self.menusDocument.document = response;
        
        // This is a dirty way of getting the newest menu if there isn't a menu for "Today"
        if (self.buildings.count == 0) {
            [[UrlsClient instance] menuDates:^(AFHTTPRequestOperation *operation, id response) {
                [[UrlsClient instance] buildingListForDate:response[0] success:^(AFHTTPRequestOperation *operation, id json) {
                    self.buildings = nil;
                    [self convertJsonToArray:json];
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


- (void)convertJsonToArray:(NSArray *)JSON{
    
    self.buildings = [[NSMutableArray alloc] initWithCapacity:[JSON count]];
    for (int i=0; i < [JSON count]; i++) {
        [self.buildings addObject:[[[JSON objectAtIndex:i] allKeys] objectAtIndex:0]];
    }
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    self.menuListViewController = [[MenuListViewController alloc] initWithName:[self.buildings objectAtIndex:indexPath.row]];
 
    // Push the view controller.
    [self.navigationController pushViewController:menuListViewController animated:YES];
}



@end
