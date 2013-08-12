//
//  BuildingListViewController.h
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuListViewController.h"

@interface BuildingListViewController : UITableViewController

@property (nonatomic, retain) MenuListViewController *menuListViewController;
@property (nonatomic, weak) IBOutlet UITableView *buildingTableView;

@end
