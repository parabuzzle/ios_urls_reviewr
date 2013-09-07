//
//  MenusDocument.m
//  urls_reviewr
//
//  Created by Mike Heijmans on 9/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "MenusDocument.h"
#import "UrlsClient.h"

@implementation MenusDocument

+ (MenusDocument *)instance {
    static dispatch_once_t once;
    static MenusDocument *instance;
    
    dispatch_once(&once, ^{
        instance = [[MenusDocument alloc] initWithArray:@[]];
    });
    
    return instance;
}

- (id) initWithArray: (NSArray *) document {
    self.document = document;
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];
    self.date = dateString;
    return self;
}

- (id) saveLocal {
    // this doesn't work because of the attempt on saving the array.. probably don't need this anyway
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.document forKey:@"menuDocument"];
    [defaults setObject:self.date forKey:@"menuDate"];
    [defaults synchronize];
    return self;
}

- (id) initLocal {
    self.document = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.document = [defaults objectForKey:@"menuDocument"];
    self.date = [defaults objectForKey:@"menuDate"];
    return self;
}

@end
