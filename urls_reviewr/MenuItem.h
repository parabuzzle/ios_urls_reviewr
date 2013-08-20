//
//  MenuItem.h
//  urls_reviewr
//
//  Created by Jesus Medrano on 8/19/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ratings;
@property (nonatomic) NSString *numberOfComments;
@property (nonatomic, strong) NSMutableArray *commentsList;

@end
