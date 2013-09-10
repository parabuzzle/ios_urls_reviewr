//
//  AddRatingViewController.m
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "AddRatingViewController.h"
#import "UrlsClient.h"
#import "MenuItem.h"
#import "MenuItemViewController.h"
#import "AccountSetupViewController.h"
#import "MenusDocument.h"
#import "User.h"

@interface AddRatingViewController ()

@property (nonatomic, strong) MenuItem *menuItem;
@property (nonatomic, assign) float rating;
@property (nonatomic, weak) MenuItemViewController *viewController;
- (void)accountSetup;

@end

@implementation AddRatingViewController

- (id)initWithMenuItem:(MenuItem *)menuItem andController:(MenuItemViewController *)viewController{
    self = [super init];
    self.menusDocument = [MenusDocument instance];
    self.menuItem = menuItem;
    self.viewController = viewController;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)onCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onSaveButton:(id)sender {
    
    if(self.rating < 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rating Missing" message:@"Please Select a Rating" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    Comment *comment;
    if ([self.menuItem myComment]) {
        comment = [self.menuItem myComment];
    } else {
        comment = [[Comment alloc] init];
    }
    
    if(self.textView.text.length > 0){
        comment.text = self.textView.text;
    } else {
        comment.text = @"";
    }
    
    comment.menuItemId = [NSString stringWithFormat:@"%d", self.menuItem.menuItemId];
    NSString *rating = [NSString stringWithFormat:@"%f", self.rating];
    self.menuItem.rating = [NSNumber numberWithFloat:self.rating];
    
    [[UrlsClient instance] postCommentsForMenuItem:comment withRating:rating success:^(AFHTTPRequestOperation *operation, id response) {
        //NSLog(@"Posting menu item\n\n%@", response);
        
        NSDictionary *menuItemDictionary = [response objectForKey:@"item"];
        self.menuItem.reviewers = [[menuItemDictionary objectForKey:@"reviewers"] integerValue];
        self.menuItem.rating =  [NSNumber numberWithFloat:[[menuItemDictionary objectForKey:@"rating"] doubleValue]];
        
        if ([self.menuItem myComment].commentId > 0) {
            [self.menuItem addComment:comment];
        }
        
        [self.viewController reloadUI];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog([NSString stringWithFormat:@"Failed to post menu item\nError: %@", error]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something Went Wrong" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(accountSetup) withObject:nil afterDelay:0.5];
    // Do any additional setup after loading the view from its nib.
    self.rateView.notSelectedImage = [UIImage imageNamed:@"singlestar_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"singlestar_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"singlestar_full.png"];
    self.rateView.rating = 0;
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
    
    self.textView.text = [self.menuItem myComment].text;

}

- (void)accountSetup {
    User *user = [[User alloc] initLocal];
    
    if (user.userid == nil) {
        AccountSetupViewController *accountView = [[AccountSetupViewController alloc] init];
        // display accountsetup
        [self presentViewController:accountView animated:YES completion:NULL];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
    self.rating = rating;
    NSLog([NSString stringWithFormat:@"Rating: %f", rating]);
}

@end
