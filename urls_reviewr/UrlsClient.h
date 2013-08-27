//
//  UrlsClient.h
//  urls_reviewr
//
//  Created by Jesus Medrano on 8/19/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@interface UrlsClient : AFHTTPClient

+ (UrlsClient *)instance;

- (void)buildingList:
             (void (^)(AFHTTPRequestOperation *operation, id response))successs
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (NSMutableArray *)menuListWithBuilding:(NSString *)building;

@end
