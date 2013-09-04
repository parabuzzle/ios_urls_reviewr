//
//  MenuItemViewController.m
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "MenuItemViewController.h"
#import "MenuItem.h"
#import "UrlsClient.h"
#import "AddRatingViewController.h"
#import "Comment.h"

@interface MenuItemViewController ()

- (void)shareItem;

@end

@implementation MenuItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (id)initWithName:(MenuItem *)menuItem{
    self = [super initWithNibName:@"MenuItemViewController" bundle:nil];
    self.menuItem = menuItem;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRating)];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareItem)];
    self.navigationItem.rightBarButtonItems = @[addButton, shareButton];
    self.menuItemDescription.numberOfLines = 0;
    [self.menuItemDescription sizeToFit];
    
    self.commentsListView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.commentsListView.delegate = self;
    self.commentsListView.dataSource = self;
    [self.commentsListView reloadData];
    [self loadMenuItemData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)loadMenuItemData{
    
    self.menuItemDescription.text = self.menuItem.description;
    if ([self.menuItemDescription.text  isEqual: @""]) {
        self.menuItemDescription.text = @"no description provided";
    }
    self.menuItemDescription.textAlignment = NSTextAlignmentCenter;
    self.menuItemName.text = self.menuItem.title;
    self.menuItemRating.text = [NSString stringWithFormat:@"%@/5", self.menuItem.stringFormattedRating];
    self.numberOfComments.text = [NSString stringWithFormat:@"%d reviewers", self.menuItem.reviewers];
    self.ratingsImageView.image = [UIImage imageNamed:self.menuItem.ratingImageName];
    
    [[UrlsClient instance] getCommentsForMenuItem:self.menuItem success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"Successfully queried comments for menu item");
        [self.menuItem loadComments:response];
        [self.commentsListView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to GET comments for menu item");
    }];
}

- (IBAction)addRating {
    // Add rating and comment modal
    AddRatingViewController *ratingView = [[AddRatingViewController alloc] initWithMenuItem:self.menuItem];
    [self presentViewController:ratingView animated:YES completion:NULL];
    
}

- (void)shareItem {
    // Email modal with url:
    // http://api.reviewr.mail.vip.gq1.yahoo.net/menu_items/545 where 545 is the item's id
    MFMailComposeViewController *email = [[MFMailComposeViewController alloc] init];
    email.mailComposeDelegate = self;
    [email setSubject:@"Check out this dish in the Cafe Today!"];
    NSString *emailBody =[NSString stringWithFormat:@"Hey,\nCheck out this dish in the cafe today: http://api.reviewr.mail.vip.gq1.yahoo.net/menu_items/%ld", (long)self.menuItem.menuItemId];
    [email setMessageBody:emailBody isHTML:NO];
    [self presentViewController:email animated:YES completion:NULL];
               
}

#pragma mark - Mailer Delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:NULL];
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
    return self.menuItem.commentsList.count;
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
    cell.textLabel.text = [[self.menuItem.commentsList objectAtIndex:indexPath.row] text];
    cell.shouldIndentWhileEditing = YES;
    [cell.textLabel sizeToFit];
//    cell.backgroundColor = [UIColor clearColor];
//    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
//    UIView *selectedBackgroundViewForCell = [UIView new];
//    [selectedBackgroundViewForCell setBackgroundColor:[UIColor purpleColor]];
//    cell.selectedBackgroundView = selectedBackgroundViewForCell;
    return cell;
}

@end
