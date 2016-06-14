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


-(void) testMinimumAndMaximumHeightOfCell {
    
    MediaTableViewCell *testCell = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"testCell"];
    
    Media *testMedia = [[Media alloc] initWithDictionary:self.sourceDictionary];
    testMedia.image = [UIImage imageNamed:@"4.jpg"];
    
    [testCell setMediaItem:testMedia];
    
    CGFloat testCellHeight = [MediaTableViewCell heightForMediaItem:testMedia width:320 traitCollection:testCell.traitCollection];
    
    
    XCTAssertLessThanOrEqual(testCellHeight, 250, @"Cell height should be less than or equal to 250");
    XCTAssertGreaterThanOrEqual(testCellHeight, 220, @"Cell height should be greater than or equal to 220");
    
    //These numbers are random.  I don't really understand what's going on here, but I know the image height is 238 with an image and 138 without.
    
}

- (void) testThatHeightOfCellWithoutImageIsLessThanCellWith {
    
    MediaTableViewCell *cellWithImage = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellWithImage"];
    MediaTableViewCell *cellNoImage = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellNoImage"];
    
    Media *mediaWithImage = [[Media alloc] initWithDictionary:self.sourceDictionary];
    Media *mediaNoImage = [[Media alloc] initWithDictionary:self.sourceDictionary];
    
    mediaWithImage.image = [UIImage imageNamed:@"4.jpg"];
    
    [cellWithImage setMediaItem:mediaWithImage];
    [cellNoImage setMediaItem:mediaNoImage];
    
    CGFloat heightWithImage = [MediaTableViewCell heightForMediaItem:mediaWithImage width:320 traitCollection:cellWithImage.traitCollection];
    CGFloat heightNoImage = [MediaTableViewCell heightForMediaItem:mediaNoImage width:320 traitCollection:cellNoImage.traitCollection];
    
    XCTAssertLessThan(heightNoImage, heightWithImage, @"Height of cell without image should be less than cell with image");
    
    
}

@end
