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

#pragma mark - Building/Cafetria API
- (void)buildingList:
             (void (^)(AFHTTPRequestOperation *operation, id response))successs
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark - User API

- (void)userInit:(NSString *) username success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)userInfo:(NSString *) userid success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark - Menu API
- (void)todaysMenu:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark - GET Comments API
- (void)getCommentsWithMenuItemId:(NSInteger *)menuItemId success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark - POST Comments API
- (void)postCommentsWithMenuItemId:(NSInteger *)menuItemId success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
