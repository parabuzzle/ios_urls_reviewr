//
//  MenuItemViewController.h
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"
#import "MenuItemCell.h"
#import <MessageUI/MessageUI.h>

@interface MenuItemViewController : UIViewController <MFMailComposeViewControllerDelegate>


@property (nonatomic, strong) MenuItem *menuItem;
@property (nonatomic, weak) IBOutlet UILabel *menuItemDescription;
@property (nonatomic, weak) IBOutlet UILabel *menuItemName;
@property (nonatomic, weak) IBOutlet UILabel *menuItemRating;
@property (nonatomic, weak) IBOutlet UILabel *numberOfComments;
@property (nonatomic, weak) IBOutlet UITableView *commentsListView;
@property (nonatomic, weak) IBOutlet UIImageView *ratingsImageView;

- (IBAction)addRating;

- (id)initWithName:(MenuItem *)theMenuItem;



@end
