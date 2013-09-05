//
//  MenuItem.m
//  urls_reviewr
//
//  Created by Jesus Medrano on 8/19/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "MenuItem.h"
#import "Comment.h"

@implementation MenuItem

+ (NSMutableArray *)menuItemWithArray:(NSArray *)array {
    NSMutableArray *menuItems = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [menuItems addObject:[[MenuItem alloc] initWithDictionary:params]];
    }
    return menuItems;
}

+ (MenuItem *)fromJSON:(NSDictionary *)JsonDictionary {
    
    MenuItem *menuItem = [[MenuItem alloc] init];
    
    menuItem.menuItemId = [[JsonDictionary objectForKey:@"id"] integerValue];
    menuItem.menuId = [[JsonDictionary objectForKey:@"menu_id"] integerValue];
    menuItem.title = [JsonDictionary objectForKey:@"title"];
    menuItem.description = [JsonDictionary objectForKey:@"description"];
    menuItem.rating = [NSNumber numberWithFloat:[[JsonDictionary objectForKey:@"rating"] floatValue]];
    menuItem.vegan = [[JsonDictionary objectForKey:@"vegan"] boolValue];
    menuItem.vegitarian = [[JsonDictionary objectForKey:@"vegitarian"] boolValue];
    menuItem.glutenFree = [[JsonDictionary objectForKey:@"gluten_free"] boolValue];
    menuItem.farmToFork = [[JsonDictionary objectForKey:@"farm_to_fork"] boolValue];
    menuItem.seafoodWatch = [[JsonDictionary objectForKey:@"seafood_watch"] boolValue];
    menuItem.createdAt = [JsonDictionary objectForKey:@"created_at"];
    menuItem.updatedAt = [JsonDictionary objectForKey:@"updated_at"];
    menuItem.reviewers = [[JsonDictionary objectForKey:@"reviewers"] integerValue];

    if([menuItem.description isKindOfClass:[NSNull class]]){
        menuItem.description = @"";
    }
    
    return menuItem;
    
}

- (NSString *)ratingImageName {

    NSString *starRating = [self stringFormattedRating];
    starRating = [starRating stringByReplacingOccurrencesOfString:@"." withString:@""];

    return [NSString stringWithFormat:@"round-rating%@-150.png", starRating];
}

- (NSString *)ratingImageNameinWhite {
    
    NSString *starRating = [self stringFormattedRating];
    starRating = [starRating stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    return [NSString stringWithFormat:@"round-rating%@-150-white.png", starRating];
}

- (NSString *)stringFormattedRating {
    float floatValue = round(self.rating.floatValue * 2.0f) / 2;
    NSString *starRating = [NSString stringWithFormat:@"%.1f", floatValue];
    
    if (!(floatValue - floor(floatValue) > 0)){
        starRating = [starRating stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    return starRating;
}

- (void)loadComments:(NSArray *)Json {
    self.commentsList = [[NSMutableArray alloc] init];
    
    for (int i=0; i<Json.count; i++) {
        [self.commentsList addObject:[[Comment alloc] initWithDictionary:[Json objectAtIndex:i]]];
    }
}

- (void)addComment:(Comment *)comment {
    [self.commentsList addObject:comment];
}

@end
