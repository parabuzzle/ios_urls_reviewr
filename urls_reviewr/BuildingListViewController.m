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

@interface BuildingListViewController ()

@property (nonatomic, strong) NSMutableArray *buildings;
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
    
    return cell;
}

#pragma mark - Private methods

- (void)loadBuildingData {

    //Load data from backend server
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[[NSURL alloc]initWithString:@"http://fe01.reviewr.mail.gq1.yahoo.net/today.json"]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
         [self convertJsonToArray:JSON];
         [self.tableView reloadData];
         
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
         NSLog(@"Failed ==========\n%@ %@", error, JSON);

     }];
    [operation start];
    

    [self.tableView reloadData];
    //Hardcoded values
//    self.buildingArray = [[NSMutableArray alloc] initWithObjects:@"URLs", @"Building E", @"Building F", @"Building G", nil];
    
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

    // Pass the selected object to the new view controller.
    NSLog([NSString stringWithFormat:@"Selected object: %@", [self.buildings objectAtIndex:indexPath.row]]);
    
    // Push the view controller.
    [self.navigationController pushViewController:menuListViewController animated:YES];
}



@end
