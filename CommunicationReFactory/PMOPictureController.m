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

static void *DownloadedDataObservation = &DownloadedDataObservation;

@interface PMOPictureController()

//1
/**
 Our private data class, storing and hiding the information.
 */
@property (strong, nonatomic, nullable) PMOPictureWithURL *pictureWithUrl;

/**
 The downloader, which downloads the data. We need to keep it as a property as long as
 we want to use the Key-Value Observation
 */
@property (strong, nonatomic, nullable) PMODownloader *downloader;
@end

@implementation PMOPictureController

#pragma mark - Initializers
- (instancetype)initWithPictureURL:(NSURL *)url {
    
    self = [super init];
    if (self) {
        _pictureWithUrl = [[PMOPictureWithURL alloc] initWithPictureURL:url];
        _downloader = [[PMODownloader alloc] init];
        [self addObserverForKeyValueObservationDownloader:_downloader];
        [self addObserverForDownloadTaskWithDownloader];
    }
    return self;
}


#pragma mark - Public API
- (void)downloadImage {
    //2
    [self.downloader downloadDataFromURL:self.pictureWithUrl.imageURL];
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
- (void)addObserverForKeyValueObservationDownloader:(PMODownloader *)downloader {
    [downloader addObserver:self forKeyPath:@"downloadedData"
                    options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                    context:DownloadedDataObservation];
    
}

//4
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == DownloadedDataObservation) {
        [self willChangeValueForKey:@"image"];
        self.pictureWithUrl.image = [UIImage imageWithData:self.downloader.downloadedData];
        [self didChangeValueForKey:@"image"];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//5
- (void)addObserverForDownloadTaskWithDownloader {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didImageDownloadFailed)
                                                 name:PMODownloadFailed
                                               object:nil];
}


- (void)removeObserverForDownloadTask {
    //6
    [self.downloader removeObserver:self forKeyPath:@"downloadedData" context:DownloadedDataObservation];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Dealloc
- (void)dealloc {
    [self removeObserverForDownloadTask];
    self.downloader = nil;
}

@end
