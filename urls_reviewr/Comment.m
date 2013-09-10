//
//  Comment.m
//  urls_reviewr
//
//  Created by Jesus Medrano on 9/3/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "Comment.h"

@implementation Comment

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [[Comment alloc] init];
    self.createdAt = [dictionary objectForKey:@"created_at"];
    self.commentId = [dictionary objectForKey:@"comment_id"];
    self.menuItemId = [dictionary objectForKey:@"menu_item_id"];
    self.text = [dictionary objectForKey:@"text"];
    self.updatedAt = [dictionary objectForKey:@"updated_at"];
    self.userId = [dictionary objectForKey:@"user_id"];
    self.username = [dictionary objectForKey:@"username"];
    self.userRating = [[dictionary objectForKey:@"user_rating"] integerValue];
    
    return self;
}

@end
