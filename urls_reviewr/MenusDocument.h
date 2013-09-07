//
//  MenusDocument.h
//  urls_reviewr
//
//  Created by Mike Heijmans on 9/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenusDocument : NSObject

@property (nonatomic, strong) NSArray *document;
@property (nonatomic, strong) NSString *date;

+ (MenusDocument *)instance;
- (id) initWithArray: (NSArray *) document;
- (id) saveLocal;
- (id) initLocal;

@end
