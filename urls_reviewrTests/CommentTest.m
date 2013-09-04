//
//  CommentTest.m
//  urls_reviewr
//
//  Created by Jesus Medrano on 9/3/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Comment.h"

@interface CommentTest : XCTestCase

@property (nonatomic, strong) Comment *comment;
@property (nonatomic, strong) NSMutableArray *json;

@end

@implementation CommentTest

- (void)setUp
{
    [super setUp];
    
    NSDictionary *commentDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"2013-09-03T11:36:02.000-07:00", @"created_at", @"5", @"id", @"545", @"menu_item_id", @"Amazing! I would totally get it again.", @"text", @"2013-09-03T11:36:02.000-07:00", @"updated_at", @"5", @"user_id", @"parabuzzle@gmail.com", @"username", nil];
    
    self.json = [[NSMutableArray alloc] initWithObjects:commentDictionary, nil];
    self.comment = [[Comment alloc] init];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testCreatedAt
{
    NSString *createdAt = @"2013-09-03T11:36:02.000-07:00";
    self.comment.createdAt = createdAt;
    XCTAssertEqualObjects(createdAt, self.comment.createdAt, @"created at test");
}

- (void)testCommentId
{
    NSString *commentId = @"5";
    self.comment.commentId = commentId;
    XCTAssertEqualObjects(commentId, self.comment.commentId, @"commentId test");
}

- (void)testMenuItemId
{
    NSString *menuItemId = @"545";
    self.comment.menuItemId = menuItemId;
    XCTAssertEqualObjects(menuItemId, self.comment.menuItemId, @"menuItemId test");
}

- (void)testText
{
    NSString *text = @"Amazing! I would totally get it again.";
    self.comment.text = text;
    XCTAssertEqualObjects(text, self.comment.text, @"text test");
}

- (void)testUpdatedAt
{
    NSString *updatedAt = @"2013-09-03T11:36:02.000-07:00";
    self.comment.updatedAt = updatedAt;
    XCTAssertEqualObjects(updatedAt, self.comment.updatedAt, @"updatedAt test");
}

- (void)testUserId
{
    NSString *userId = @"5";
    self.comment.userId = userId;
    XCTAssertEqualObjects(userId, self.comment.userId, @"user_id test");
}

- (void)testUsername
{
    NSString *username = @"parabuzzle@gmail.com";
    self.comment.username = username;
    XCTAssertEqualObjects(username, self.comment.username, @"username test");
}

- (void)testLoadingFromJson {
    
    Comment *comment = [[Comment alloc] init];
    NSDictionary *dict = [self.json objectAtIndex:0];
    comment.createdAt = [dict objectForKey:@"created_at"];
    comment.commentId = [dict objectForKey:@"comment_id"];
    comment.menuItemId = [dict objectForKey:@"menu_item_id"];
    comment.text = [dict objectForKey:@"text"];
    comment.updatedAt = [dict objectForKey:@"updated_at"];
    comment.userId = [dict objectForKey:@"user_id"];
    comment.username = [dict objectForKey:@"username"];
    self.comment = [[Comment alloc] initWithDictionary:dict];
    XCTAssertEqualObjects(self.comment.createdAt, comment.createdAt, @"comments equal");
    XCTAssertEqualObjects(self.comment.commentId, comment.commentId, @"comments equal");
    XCTAssertEqualObjects(self.comment.menuItemId, comment.menuItemId, @"comments equal");
    XCTAssertEqualObjects(self.comment.text, comment.text, @"comments equal");
    XCTAssertEqualObjects(self.comment.updatedAt, comment.updatedAt, @"comments equal");
    XCTAssertEqualObjects(self.comment.userId, comment.userId, @"comments equal");
    XCTAssertEqualObjects(self.comment.username, comment.username, @"comments equal");
}

@end
