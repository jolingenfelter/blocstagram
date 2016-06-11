//
//  ComposeCommentViewTests.m
//  Blocstagram
//
//  Created by Joanna Lingenfelter on 6/11/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ComposeCommentView.h"

@interface ComposeCommentViewTests : XCTestCase

@end

@implementation ComposeCommentViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testIsWriting {
    ComposeCommentView *testText = [[ComposeCommentView alloc] init];
    testText.text = @"Testing text";
    
    ComposeCommentView *testNoText = [[ComposeCommentView alloc] init];
    testNoText.text = @"";
    
    XCTAssertTrue(testText.isWritingComment);
    XCTAssertFalse(testNoText.isWritingComment);
}

@end
