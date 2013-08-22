//
//  UrlsClient.m
//  urls_reviewr
//
//  Created by Jesus Medrano on 8/19/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "UrlsClient.h"
#import "AFNetworking.h"

#define BACKEND_BASE_URL [NSURL URLWithString:@"http://fe01.reviewr.mail.gq1.yahoo.net/"]

@implementation UrlsClient

+ (UrlsClient *)instance {
    static dispatch_once_t once;
    static UrlsClient *instance;
    
    dispatch_once(&once, ^{
        instance = [[UrlsClient alloc] initWithBaseURL:BACKEND_BASE_URL];
    });
    
    return instance;
}

- (UrlsClient *)init {
    
    self = [super init];

    if (self != nil) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        //NSData *data = [NSUserDefaults standardUserDefaults];

    }

    return self;
}


#pragma mark - Building API

- (void)buildingList:
             (void (^)(AFHTTPRequestOperation *operation, id response))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    //NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"count": @(count)}];
    [self getPath:@"locations/today.json" parameters:nil success:success failure:failure];
    
}


@end
