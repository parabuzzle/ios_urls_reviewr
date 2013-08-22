//
//  MenuItem.m
//  urls_reviewr
//
//  Created by Jesus Medrano on 8/19/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem


+ (NSMutableArray *)menuItemWithArray:(NSArray *)array {
    NSMutableArray *menuItems = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [menuItems addObject:[[MenuItem alloc] initWithDictionary:params]];
    }
    return menuItems;
}

@end
