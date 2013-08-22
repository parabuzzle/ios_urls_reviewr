//
//  Building.h
//  urls_reviewr
//
//  Created by Jesus Medrano on 8/20/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "RestObject.h"

@interface Building : RestObject

@property (nonatomic, strong) NSArray *array;
+ (NSArray *)buildlingsFromServer:(UITableView *)sender;

@end
