//
//  PMODownloader.m
//  CommunicationReFactory
//
//  Created by Peter Molnar on 03/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODownloader.h"
#import "PMODownloadNotifications.h"

@implementation PMODownloader

#pragma mark - Public API
- (void)downloadDataFromURL:(NSURL *)url {

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (error) {
                                          [self notifyObserverDownloadFailure];
                                      } else {
                                          [self notifyObserverWithProcessedData:data];
                                      }
                                  }];
    [task resume];

}

#pragma mark - Accessors
- (void)setDownloadedData:(NSData *)downloadedData {
    if (!_downloadedData) {
        _downloadedData = [[NSData alloc] init];
    }
    _downloadedData = downloadedData;
}

#pragma mark - Notifications
- (void)notifyObserverWithProcessedData:(NSData *)data {
    [self willChangeValueForKey:@"downloadedData"];
    self.downloadedData = data;
    [self didChangeValueForKey:@"downloadedData"];
}


- (void)notifyObserverDownloadFailure {

    [[NSNotificationCenter defaultCenter] postNotificationName:PMODownloadFailed
                                                        object:self
                                                      userInfo:nil];
}
@end
