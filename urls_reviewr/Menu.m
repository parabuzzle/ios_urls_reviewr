//
//  Menu.m
//  urls_reviewr
//
//  Created by Jesus Medrano on 8/26/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "Menu.h"
#import "MenuItem.h"

@implementation Menu

- (Menu *)init {
    self = [super init];
    
    self.menuItems = [[NSMutableArray alloc] init];
    
    return self;
}

+ (Menu *)fromJSON:(NSDictionary *)jsonDictionary {
    
    Menu *menu = [[Menu alloc] init];
    
    NSArray *menuItems = [jsonDictionary objectForKey:@"menu_items"];
    for(int i=0; i < menuItems.count; i++){
        MenuItem *menuItem = [MenuItem fromJSON:[menuItems objectAtIndex:i]];
        [menu.menuItems addObject:menuItem];
    }
    
    return menu;
    
}


@end
