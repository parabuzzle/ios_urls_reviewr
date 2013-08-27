//
//  User.h
//  urls_reviewr
//
//  Created by Mike Heijmans on 8/26/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "RestObject.h"

@interface User : RestObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userid;

- (id) initWithUsername: (NSString *) username;
- (id) initWithID: (NSString *) userid andUsername: (NSString *) username andToken: (NSString *) token;
- (id) saveLocal;
- (id) initLocal;

@end
