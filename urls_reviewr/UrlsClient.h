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

@interface UrlsClient : AFHTTPClient

+ (UrlsClient *)instance;

- (void)buildingList:(AFHTTPRequestOperation *)operation
             success:(void (^)(AFHTTPRequestOperation *operation, id response))successs
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
