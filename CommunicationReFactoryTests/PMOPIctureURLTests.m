//
//  PMOPIctureURLTests.m
//  CommunicationReFactory
//
//  Created by Peter Molnar on 30/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMOPictureWithURL.h"

#define PICTURE_URL [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/en/4/45/One_black_Pixel.png"]

@interface PMOPIctureURLTests : XCTestCase

@end

@implementation PMOPIctureURLTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

//Save the diagnostic state
#pragma clang diagnostic push

//Ignore -Wnonnull warnings
#pragma clang diagnostic ignored "-Wnonnull"
- (void)testIfNilPassed {
    
    XCTAssertThrows([[PMOPictureWithURL alloc] initWithPictureURL:nil]);
}
//Restore the diagnostic state
#pragma clang diagnostic pop

- (void)testDefaultInitializer {
    
    XCTAssertThrows([[PMOPictureWithURL alloc] init]);
    
}

- (void)testDesignatedInitializer {
    PMOPictureWithURL *pictureWithURL = [[PMOPictureWithURL alloc] initWithPictureURL:PICTURE_URL];
    
    XCTAssertNotNil(pictureWithURL);
    XCTAssertNotNil(pictureWithURL.imageURL);
    XCTAssertTrue([[pictureWithURL.imageURL absoluteString] isEqualToString:[PICTURE_URL absoluteString]]);
}

@end
