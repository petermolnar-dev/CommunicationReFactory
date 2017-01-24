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


#pragma mark - Public API / Protocol implementation
- (void)downloadDataFromURL:(nonnull NSURL *)url completionHander:(void(^_Nonnull)(NSData * _Nullable downloadedData))callback {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (error) {
                                          [self notifyObserverDownloadFailure];
                                      } else {
                                          callback(data);
                                      }
                                  }];
    [task resume];
    
}


#pragma mark - Notifications
- (void)notifyObserverDownloadFailure {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PMODownloadFailed
                                                        object:self
                                                      userInfo:nil];
}



@end
