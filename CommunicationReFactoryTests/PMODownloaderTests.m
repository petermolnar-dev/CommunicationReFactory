//
//  PMODownloaderTests.m
//  CommunicationReFactory
//
//  Created by Peter Molnar on 22/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMODownloader.h"
#import "PMODownloadNotifications.h"

@interface PMODownloaderTests : XCTestCase
@property (strong, nonatomic) PMODownloader *downloader;
@end

@implementation PMODownloaderTests

- (void)setUp {
    [super setUp];
    self.downloader = [[PMODownloader alloc] init];
}

- (void)tearDown {
    self.downloader = nil;
    [super tearDown];
}


/**
 Testing the download failure wiht a nonexisting domain
 */
- (void)testPictureAsyncDownloadFailed {
    

    
    XCTestExpectation *expectation = [self expectationForNotification:PMODownloadFailed
                                                               object: nil
                                                              handler:^BOOL(NSNotification * _Nonnull notification) {
                                                                  [expectation fulfill];
                                                                  return true;
                                                              }];
    
    [self.downloader downloadDataFromURL:[NSURL URLWithString:@"https://ThereIsNoSuCHDomainName/MssedUPName.png"] completionHander:^(NSData *data){ NSLog(@"Callback"); }];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}


@end
