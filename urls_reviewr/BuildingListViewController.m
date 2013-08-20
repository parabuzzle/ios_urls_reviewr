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

@interface BuildingListViewController ()

@property (nonatomic, strong) NSMutableArray *buildingArray;
- (void)loadBuildingData;

@end

@implementation BuildingListViewController

@synthesize menuListViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Cafeterias";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadBuildingData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return self.buildingArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.buildingArray objectAtIndex:indexPath.row];
    cell.shouldIndentWhileEditing = YES;
    
    return cell;
}

#pragma mark - Private methods

- (void)loadBuildingData {
    #warning Potentially incomplete method implementation.
    //This should load data from backend server

    [[UrlsClient instance] buildingList:success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"%@", response);
            //self.tweets = [Tweet tweetsWithArray:response];
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            // Do nothing
    }];
    
    //Hardcoded values
    self.buildingArray = [[NSMutableArray alloc] initWithObjects:@"URLs", @"Building E", @"Building F", @"Building G", nil];
    
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    //if (self.menuListViewController == nil) {
         self.menuListViewController = [[MenuListViewController alloc] initWithName:[self.buildingArray objectAtIndex:indexPath.row]];
    //}

    // Pass the selected object to the new view controller.
    NSLog([NSString stringWithFormat:@"Selected object: %@", [self.buildingArray objectAtIndex:indexPath.row]]);
    //self.menuListViewController.selectedBuidling = [self.buildingArray objectAtIndex:indexPath.row];
    
    // Push the view controller.
    [self.navigationController pushViewController:menuListViewController animated:YES];
}



@end
