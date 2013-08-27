//
//  User.m
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/26/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "User.h"

@implementation User

- (id) initWithUsername: (NSString *) username {
    self.username = username;
    return self;
}

- (id) initWithID: (NSString *) userid andUsername: (NSString *) username andToken: (NSString *) token {
    self.userid = userid;
    self.username = username;
    self.token = token;
    return self;
}

- (id) initWithDictionary: (NSDictionary *) userDict {
    self.userid = [userDict objectForKey:@"id"];
    self.username = [userDict objectForKey:@"username"];
    self.token = [userDict objectForKey:@"token"];
    return self;
}

- (id) saveLocal {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.username forKey:@"username"];
    [defaults setObject:self.userid forKey:@"userid"];
    [defaults setObject:self.token forKey:@"token"];
    [defaults synchronize];
    return self;
}

- (id) initLocal {
    self.userid = @"0";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.username = [defaults objectForKey:@"username"];
    self.userid = [defaults objectForKey:@"userid"];
    self.token = [defaults objectForKey:@"token"];
    return self;
}

@end
