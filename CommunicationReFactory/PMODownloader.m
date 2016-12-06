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
//2
                                          self.downloadedData = data;
                                      }
                                  }];
    [task resume];
    
}

//3
#pragma mark - Accessors
- (void)setDownloadedData:(NSData *)downloadedData {
    [self willChangeValueForKey:@"downloadedData"];
    if (!_downloadedData) {
        _downloadedData = [[NSData alloc] init];
    }
    _downloadedData = downloadedData;
    [self didChangeValueForKey:@"downloadedData"];
}


#pragma mark - Notifications



- (void)notifyObserverDownloadFailure {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PMODownloadFailed
                                                        object:self
                                                      userInfo:nil];
}


@end
