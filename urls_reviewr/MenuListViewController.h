//
//  MenuListViewController.h
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItemCell.h"
#import "MenusDocument.h"

@interface MenuListViewController : UITableViewController

@property (nonatomic, retain) NSString *selectedBuidling;
@property (assign, nonatomic) IBOutlet MenuItemCell *menuItemCell;
@property (nonatomic, retain) MenusDocument *menusDocument;

- (id)initWithName:(NSString *)theName;

@end
