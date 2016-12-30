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


@interface PMOPictureController()

/**
 Our private data class, storing and hiding the information.
 */
@property (strong, nonatomic, nullable) PMOPictureWithURL *pictureWithUrl;


@end

@implementation PMOPictureController

@synthesize delegate = _delegate;

#pragma mark - Initializers
- (instancetype)initWithPictureURL:(NSURL *)url {
    
    self = [super init];
    if (self) {
        _pictureWithUrl = [[PMOPictureWithURL alloc] initWithPictureURL:url];
        PMODownloader *delegate = [[PMODownloader alloc] init];
        delegate.receiver = self;
        _delegate = delegate;
        [self addObserverForDownloadTaskWithDownloader];
    }
    return self;
}


#pragma mark - Public API
- (void)downloadImage {
    [self.delegate downloadDataFromURL:self.pictureWithUrl.imageURL];
}


- (void)didDownloadedData:(NSData *)data {
    if (data) {
        [self willChangeValueForKey:@"image"];
        self.pictureWithUrl.image = [UIImage imageWithData:data];
        [self removeObserverForDownloadTask];
        [self didChangeValueForKey:@"image"];
    }
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
