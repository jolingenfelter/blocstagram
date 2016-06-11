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

@end

@implementation MediaTableViewCellTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testAccurateHeightOfMediaItem {
    
    MediaTableViewCell *testCell = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    NSDictionary *testImages = @{@"image" : [UIImage imageNamed: @"4.jpg"]};
    
    Media *testMedia = [[Media alloc] initWithDictionary:testImages];

}
@end
