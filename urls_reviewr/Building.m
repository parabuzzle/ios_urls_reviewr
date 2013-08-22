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
    
//    for (NSDictionary *params in array) {
//        [buildings addObject:[[Building alloc] initWithDictionary:params]];
//    }
    
//    [[UrlsClient instance] buildingList:^(AFHTTPRequestOperation *operation, id response) {
//        //NSLog(@"%@", response);
//        NSLog(@"%@", [[response class] description]);
//        //NSMutableArray *buildingData = [Building buildlingsWithArray:response];
//        //NSLog(@"%@", buildingData);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Failed to load building data");
//    }];
    
//    return buildings;
}

- (NSString *)name {
    return [self.data valueForKeyPath:@"name"];
}

@end
