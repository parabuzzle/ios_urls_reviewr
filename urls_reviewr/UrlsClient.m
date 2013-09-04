//
//  UrlsClient.m
//  urls_reviewr
//
//  Created by Jesus Medrano on 8/19/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "UrlsClient.h"
#import "AFNetworking.h"
#import "MenuItem.h"
#import "Comment.h"

#define BACKEND_BASE_URL [NSURL URLWithString:@"http://api.reviewr.mail.vip.gq1.yahoo.net/"]

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
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self getPath:@"today.json" parameters:nil success:success failure:failure];
    
}

- (void)buildingListForDate:(NSString *) date success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self getPath:@"all_by_date.json" parameters:@{@"date":date} success:success failure:failure];
    
}

- (void)menuDates: (void (^)(AFHTTPRequestOperation *operation, id response))successs
          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self getPath:@"recent_dates_with_menus.json" parameters:@{@"limit":@"1"} success:successs failure:failure];
}

#pragma mark - User API

- (void)userInit:(NSString *) username success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    // creates a user
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self postPath:@"users.json" parameters:@{@"username" : username} success:success failure:failure];
    
}

- (void)userInfo:(NSString *) userid success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    // Returns user info by userid
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self getPath:[NSString stringWithFormat:@"users/%@.json", userid] parameters:nil success:success failure:failure];
}

#pragma mark - Menu API

- (void)todaysMenu:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self getPath:@"today.json" parameters:nil success:success failure:failure];
}

- (void)menuByDate:(NSString *) date success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self getPath:@"all_by_date.json" parameters:@{@"date":date} success:success failure:failure];
}


#pragma mark - GET Comments API
- (void)getCommentsForMenuItem:(MenuItem *)menuItem success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self getPath:[NSString stringWithFormat:@"menu_items/%d/comments.json", menuItem.menuItemId] parameters:nil success:success failure:failure];
    
}

#pragma mark - POST Comments API
- (void)postCommentsForMenuItem:(Comment *)comment withRating:(NSString *)rating success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userid"], @"user_id", rating, @"rating", comment.text, @"comment", nil];
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self postPath:[NSString stringWithFormat:@"/menu_items/%@/rate.json", comment.menuItemId] parameters:parameters success:success failure:failure];
    
}


@end
