//
//  MenuItemViewController.h
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemViewController : UIViewController

@property (nonatomic, retain) NSString *selectedMenuItem;
@property (nonatomic, weak) IBOutlet UILabel *menuItemDescription;
@property (nonatomic, weak) IBOutlet UILabel *menuItemName;
@property (nonatomic, weak) IBOutlet UILabel *menuItemRating;
@property (nonatomic, weak) IBOutlet UILabel *numberOfComments;
@property (nonatomic, weak) IBOutlet UITableView *commentsListView;

- (id)initWithName:(NSString *)theMenuItem;

@end
