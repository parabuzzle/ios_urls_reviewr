//
//  Comment.h
//  urls_reviewr
//
//  Created by Jesus Medrano on 9/3/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, strong) NSString *menuItemId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *updatedAt;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic) NSInteger userRating;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
