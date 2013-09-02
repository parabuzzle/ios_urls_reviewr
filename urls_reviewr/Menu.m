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

+ (Menu *)fromJSON:(NSDictionary *)mealtimeJson {
    
    Menu *menu = [[Menu alloc] init];
    NSArray *menus = [mealtimeJson objectForKey:@"menus"];
    
    for(int i=0; i < menus.count; i++){
        NSDictionary *jsonMenu = [menus objectAtIndex:i];
        NSArray *menuItems = [jsonMenu objectForKey:@"menu_items"];
        for (int j=0; j < menuItems.count; j++) {
            MenuItem *menuItem = [MenuItem fromJSON:[menuItems objectAtIndex:j]];
            [menu.menuItems addObject:menuItem];
        }
        
    }
    
    return menu;
    
}


@end
