//
//  Building.m
//  urls_reviewr
//
//  Created by Jesus Medrano on 8/20/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "Building.h"
#import "AFNetworking.h"
#import "UrlsClient.h"

@implementation Building

+ (NSArray *)buildlingsFromServer:(UITableView *)sender{
    
    Building *building = [[Building alloc] init];
    return building.array;

}

- (NSString *)name {
    return [self.data valueForKeyPath:@"name"];
}

@end
