//
//  MediaTableViewCellTests.m
//  Blocstagram
//
//  Created by Joanna Lingenfelter on 6/11/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MediaTableViewCell.h"
#import "Media.h"

@interface MediaTableViewCellTests : XCTestCase

@property (nonatomic, strong) NSDictionary *sourceDictionary;

@end

@implementation MediaTableViewCellTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.sourceDictionary= @{@"id": @"9999999",
                        @"images" : @{@"standard_resolution" : @{@"url" : @"http://www.melbo.co"}},
                        @"user_had_liked" : @"0",
                        @"caption" : @{@"text" : @"texttesxttext"},
                        @"user" : @{@"id" : @"1234567",
                                    @"username" : @"Freckles",
                                    @"full_name" : @"Homer Simpson",
                                    @"profile_picture" : @"@http://www.example.com/example.jpg"}
                        };
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testHeightOfMediaItem {
    

    MediaTableViewCell *testCell1 = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    MediaTableViewCell *testCell2 = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    UIImage *testImage1 = [UIImage imageNamed: @"4.jpg"];
    UIImage *testImage2 = [UIImage imageNamed:@"10.jpg"];
    
    Media *testMedia1 = [[Media alloc] initWithDictionary:self.sourceDictionary];
    testMedia1.image = testImage1;
    Media *testMedia2 = [[Media alloc] initWithDictionary:self.sourceDictionary];
    testMedia2.image = testImage2;
    
    [testCell1 setMediaItem:testMedia1];
    [testCell2 setMediaItem:testMedia2];
    
    CGFloat width = 423;
    CGFloat imageHeight1 = [MediaTableViewCell heightForMediaItem:testMedia1 width:width traitCollection:testCell1.traitCollection];
    CGFloat imageHeight2 = [MediaTableViewCell heightForMediaItem:testMedia2 width:width traitCollection:testCell2.traitCollection];
    
    XCTAssertGreaterThan(imageHeight1, 225);
    XCTAssertGreaterThan(imageHeight2, 225);
    
    XCTAssertLessThan(imageHeight1, 250);
    XCTAssertLessThan(imageHeight2, 250);


}
@end
