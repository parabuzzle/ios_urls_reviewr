//
//  MenuItem.h
//  urls_reviewr
//
//  Created by Jesus Medrano on 8/19/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestObject.h"
#import "Menu.h"

@interface MenuItem : RestObject

@property (nonatomic) NSInteger menuItemId;
@property (nonatomic) NSInteger menuId;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *title;
@property (nonatomic) BOOL vegitarian;
@property (nonatomic) BOOL glutenFree;
@property (nonatomic) BOOL vegan;
@property (nonatomic) BOOL farmToFork;
@property (nonatomic) BOOL seafoodWatch;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic) NSInteger reviewers;
@property (nonatomic, strong) NSMutableArray *commentsList;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *updatedAt;

+ (NSMutableArray *)menuItemWithArray:(NSArray *)array;
+ (MenuItem *)fromJSON:(NSDictionary *)JsonDictionary;
- (NSString *)ratingImageName;
- (NSString *)stringFormattedRating;

@end
