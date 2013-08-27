//
//  Menu.h
//  urls_reviewr
//
//  Created by Jesus Medrano on 8/26/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : NSObject

@property (nonatomic, strong) NSMutableArray *menuItems;
+ (Menu *)fromJSON:(NSDictionary *)jsonDictionary;

@end
