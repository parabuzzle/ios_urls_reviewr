//
//  MenuItemTest.m
//  urls_reviewr
//
//  Created by Jesus Medrano on 9/1/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MenuItem.h"

@interface MenuItemTest : XCTestCase

@property (nonatomic, strong) MenuItem *menuItem;

@end

@implementation MenuItemTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    
    self.menuItem = [[MenuItem alloc] init];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testRatingImageNameZero
{
    self.menuItem.rating = [NSNumber numberWithFloat:0.1423];
    XCTAssertEqualObjects([self.menuItem ratingImageName], @"round-rating0-150.png", @"ratingImageName == round-rating0-150.png");
}

- (void)testRatingImageNameHalf {
    self.menuItem.rating = [NSNumber numberWithFloat:0.4782];
    XCTAssertEqualObjects([self.menuItem ratingImageName], @"round-rating05-150.png", @"ratingImageName == round-rating05-150.png");
}

- (void)testRatingImageNameOne {
    self.menuItem.rating = [NSNumber numberWithFloat:1];
    XCTAssertEqualObjects([self.menuItem ratingImageName], @"round-rating1-150.png", @"ratingImageName == round-rating1-150.png");
}

- (void)testRatingImageNameOneHalf {
    self.menuItem.rating = [NSNumber numberWithFloat:1.5];
    XCTAssertEqualObjects([self.menuItem ratingImageName], @"round-rating15-150.png", @"ratingImageName == round-rating15-150.png");
}

- (void)testRatingImageNameTwo {
    self.menuItem.rating = [NSNumber numberWithFloat:2];
    XCTAssertEqualObjects([self.menuItem ratingImageName], @"round-rating2-150.png", @"ratingImageName == round-rating2-150.png");
}

- (void)testRatingImageNameTwoHalf {
    self.menuItem.rating = [NSNumber numberWithFloat:2.5];
    XCTAssertEqualObjects([self.menuItem ratingImageName], @"round-rating25-150.png", @"ratingImageName == round-rating25-150.png");
}

- (void)testRatingImageNameThree {
    self.menuItem.rating = [NSNumber numberWithFloat:3];
    XCTAssertEqualObjects([self.menuItem ratingImageName], @"round-rating3-150.png", @"ratingImageName == round-rating3-150.png");
}

- (void)testRatingImageNameThreeHalf {
    self.menuItem.rating = [NSNumber numberWithFloat:3.5];
    XCTAssertEqualObjects([self.menuItem ratingImageName], @"round-rating35-150.png", @"ratingImageName == round-rating35-150.png");
}

- (void)testRatingImageNameFour {
    self.menuItem.rating = [NSNumber numberWithFloat:4];
    XCTAssertEqualObjects([self.menuItem ratingImageName], @"round-rating4-150.png", @"ratingImageName == round-rating4-150.png");
}

- (void)testRatingImageNameFourHalf {
    self.menuItem.rating = [NSNumber numberWithFloat:4.5];
    XCTAssertEqualObjects([self.menuItem ratingImageName], @"round-rating45-150.png", @"ratingImageName == round-rating45-150.png");
}

- (void)testRatingImageNameFive {
    self.menuItem.rating = [NSNumber numberWithFloat:5];
    XCTAssertEqualObjects([self.menuItem ratingImageName], @"round-rating5-150.png", @"ratingImageName == round-rating5-150.png");
}

- (void)testRatingImageNameFiveSpecial {
    self.menuItem.rating = [NSNumber numberWithFloat:5];
    //XCTAssertEqualObjects([self.menuItem ratingImageName], @"round-rating5-special-150.png", @"ratingImageName == round-rating5-special-150.png");
}

@end
