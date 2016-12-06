//
//  PMOPictureControllerTests.m
//  CommunicationReFactory
//
//  Created by Peter Molnar on 10/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMOPictureController.h"
#import "PMODownloadNotifications.h"

@interface PMOPictureControllerTests : XCTestCase
@property (strong, nonatomic) PMOPictureController *pictureController;
@end

@implementation PMOPictureControllerTests

- (void)setUp {
    [super setUp];
//    Set up the controller with a valid image URL.
    self.pictureController = [[PMOPictureController alloc] initWithPictureURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/en/4/45/One_black_Pixel.png"]];
}

- (void)tearDown {
//    Being a good citizen, and nil out the strong reference, so we can safely initialize again a new instance
//    for the next test
    self.pictureController = nil;
    [super tearDown];
}


/**
 Test the asynchron download
 Internet connection required to pass this test!
 */
- (void)testPictureAsyncDownload {
    XCTestExpectation *expectation = [self keyValueObservingExpectationForObject:self.pictureController keyPath:@"image" handler:^BOOL(id  _Nonnull observedObject, NSDictionary * _Nonnull change) {
        [expectation fulfill];
        return true;
    }];
    
    [self.pictureController downloadImage];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

/**
 Testing the download failure wiht a nonexisting domain
 */
- (void)testPictureAsyncDownloadFailed {
    
    self.pictureController = [[PMOPictureController alloc] initWithPictureURL:[NSURL URLWithString:@"https://ThereIsNoSuCHDomainName/MssedUPName.png"]];
    
    XCTestExpectation *expectation = [self expectationForNotification:PMODownloadFailed
                                                               object: nil
                                                              handler:^BOOL(NSNotification * _Nonnull notification) {
                                                                  [expectation fulfill];
                                                                  return true;
                                                              }];
    
    [self.pictureController downloadImage];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}



@end
