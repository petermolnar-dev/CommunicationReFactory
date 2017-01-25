//
//  PMOPictureController.m
//  CommunicationReFactory
//
//  Created by Peter Molnar on 03/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//


#import "PMOPictureController.h"
#import "PMODownloader.h"
#import "PMOPictureWithURL.h"
#import "PMODownloadNotifications.h"

//1
typedef void (^DownloadCallBack)(NSData *);


@interface PMOPictureController()

/**
 Our private data class, storing and hiding the information.
 */
@property (strong, nonatomic, nullable) PMOPictureWithURL *pictureWithUrl;

@end

@implementation PMOPictureController



#pragma mark - Initializers
- (instancetype)initWithPictureURL:(NSURL *)url {
    
    self = [super init];
    if (self) {
        _pictureWithUrl = [[PMOPictureWithURL alloc] initWithPictureURL:url];
        [self addObserverForDownloadTaskWithDownloader];
    }
    return self;
}


#pragma mark - Public API
- (void)downloadImage {
//2
    PMODownloader *downloader = [[PMODownloader alloc] init];
    __weak __typeof__(self) weakSelf = self;

    DownloadCallBack downloadCallBack = ^void(NSData *downloadedData) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"Picture downloaded");
            [weakSelf willChangeValueForKey:@"image"];
            weakSelf.pictureWithUrl.image = [UIImage imageWithData:downloadedData];
            [weakSelf didChangeValueForKey:@"image"];
        }];
    };
    
    [downloader downloadDataFromURL:self.pictureWithUrl.imageURL completionHander:downloadCallBack];
}

#pragma mark - Accessors
- (UIImage *)image {
    return self.pictureWithUrl.image;
}


#pragma mark - Notification Events
- (void)didImageDownloadFailed {
    NSLog(@"Image download failed");
}


#pragma mark - Notification helpers
- (void)addObserverForDownloadTaskWithDownloader {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didImageDownloadFailed)
                                                 name:PMODownloadFailed
                                               object:nil];
}


- (void)removeObserverForDownloadTask {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Dealloc
- (void)dealloc {
    [self removeObserverForDownloadTask];
}

@end
