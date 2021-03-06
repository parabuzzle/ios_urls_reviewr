//
//  AddRatingViewController.h
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"
#import "RateView.h"
#import "MenusDocument.h"
#import "MenuItemViewController.h"

@interface AddRatingViewController : UIViewController<RateViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet RateView *rateView;
@property (nonatomic, strong) MenusDocument *menusDocument;

- (id)initWithMenuItem:(MenuItem *)menuItem andController:(MenuItemViewController *)viewController;

@end
