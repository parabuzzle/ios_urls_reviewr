//
//  UrlsClient.m
//  urls_reviewr
//
//  Created by Jesus Medrano on 8/19/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "UrlsClient.h"
#import "AFNetworking.h"

@implementation UrlsClient

+ (UrlsClient *)instance {
    static dispatch_once_t once;
    static UrlsClient *instance;
    
    dispatch_once(&once, ^{
        instance = [[UrlsClient alloc] init];
    });
    
    return instance;
}

- (UrlsClient *)init {
    
    self = [super init];

    if (self != nil) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
        NSData *data = [NSUserDefaults standardUserDefaults];

    }
    
    
    return self;
    
}

- (void)buildingList:(AFHTTPRequestOperation *)operation
             success:(void (^)(AFHTTPRequestOperation *operation, id response))successs
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    //NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"count": @(count)}];
    
}


@end
