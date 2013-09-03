//
//  MenuListViewController.h
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItemCell.h"

@interface MenuListViewController : UITableViewController

@property (nonatomic, retain) NSString *selectedBuidling;
@property (assign, nonatomic) IBOutlet MenuItemCell *menuItemCell;
@property (nonatomic, retain) NSArray *doc;

- (id)initWithName:(NSString *)theName andDoc:(NSArray *)doc;

@end
