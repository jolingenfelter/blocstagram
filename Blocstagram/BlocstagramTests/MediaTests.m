//
//  MediaTests.m
//  Blocstagram
//
//  Created by Joanna Lingenfelter on 6/11/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Media.h"
#import "User.h"
#import "Comment.h"

@interface MediaTests : XCTestCase

@end

@implementation MediaTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testThatInitializationWorks {
    NSDictionary *sourceDictionary = @{@"id": @"8675309",
                                     @"caption" : @{@"text" : @"caption text"},
                                       @"mediaURL" : @{@"images" : @{@"standard_resolution": @{@"url" : @"http://www.example.com/example.jpg"}}}
                                       };
    
    Media *testMedia = [[Media alloc] initWithDictionary: sourceDictionary];
    
    XCTAssertEqualObjects(testMedia.idNumber, sourceDictionary[@"id"], @"The ID number should be equal");
    XCTAssertEqualObjects(testMedia.caption, [[sourceDictionary objectForKey:@"caption"] objectForKey:@"text"], @"The captions should be equal");
    XCTAssertEqualObjects(testMedia.mediaURL, [NSURL URLWithString:sourceDictionary[@"images"][@"standard_resolotion"][@"url"]], @"The media URLs should be equal");


}


@end
