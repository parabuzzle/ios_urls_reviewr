//
//  MenuItem.h
//  urls_reviewr
//
//  Created by Jesus Medrano on 8/19/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestObject.h"

@interface MenuItem : RestObject

@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ratings;
@property (nonatomic) NSString *numberOfComments;
@property (nonatomic, strong) NSMutableArray *commentsList;

+ (NSMutableArray *)menuItemWithArray:(NSArray *)array;

@end
