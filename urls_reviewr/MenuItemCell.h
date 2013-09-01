//
//  MenuItemCell.h
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *menuItemTitleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *ratingImage;
@property (nonatomic, strong) IBOutlet UILabel *reviewsLabel;
@property (nonatomic, strong) IBOutlet UILabel *ratingLabel;

+ (NSString *)reuseIdentifier;

@end
