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

#define CLASS_NAME NSStringFromClass([self class])
#define INIT_EXCEPTION_MESSAGE [NSString stringWithFormat:@"Use [[%@ alloc] initWithPictureURL:]",CLASS_NAME]

@interface PMOPictureController()

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
    if (url) {
        self = [super init];
        if (self) {
            _pictureWithUrl = [[PMOPictureWithURL alloc] initWithPictureURL:url];
        }
        return self;
    } else {
        @throw [NSException exceptionWithName:@"Can't be initialised with null parameter"
                                       reason:INIT_EXCEPTION_MESSAGE
                                     userInfo:nil];
        return nil;
    }
    
}


//Save the diagnostic state
#pragma clang diagnostic push

//Ignore -Wobjc-designated-initializers warnings
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not designated initializer"
                                   reason:INIT_EXCEPTION_MESSAGE
                                 userInfo:nil];
    return nil;
}
//Restore the disgnostic state
#pragma clang diagnostic pop

//2
#pragma mark - Public API
- (void)downloadImage {

    [self addObserverForKeyValueObservationDownloader:self.downloader];
    [self addObserverForDownloadTaskWithDownloader];
    [self.downloader downloadDataFromURL:self.pictureWithUrl.imageURL];
}

- (UIImage *)image {
    return self.pictureWithUrl.image;
}

//3
#pragma mark - Notification Events
- (void)didImageDownloaded:(NSNotification *)notification {
    if (notification.userInfo) {
        _pictureWithUrl.image = [UIImage imageWithData:[notification.userInfo objectForKey:@"downloadedData"]];
    }
    [self removeObserverForDownloadTask];
}

- (void)didImageDownloadFailed {
    NSLog(@"Image download failed");
    [self removeObserverForDownloadTask];
}



#pragma mark - Notification helpers
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath  isEqual:@"downloadedData"] && self.downloader.downloadedData) {
        [self willChangeValueForKey:@"image"];
        self.pictureWithUrl.image = [UIImage imageWithData:self.downloader.downloadedData];
        [self didChangeValueForKey:@"image"];
    }
}

- (void)addObserverForKeyValueObservationDownloader:(PMODownloader *)downloader {
    [downloader addObserver:self forKeyPath:@"downloadedData"
                    options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                    context:nil];
    
}

- (void)addObserverForDownloadTaskWithDownloader {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didImageDownloadFailed)
                                                 name:PMODownloadFailed
                                               object:nil];
}


- (void)removeObserverForDownloadTask {
    [self.downloader removeObserver:self forKeyPath:@"downloadedData"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Dealloc
- (void)dealloc {
    [self removeObserverForDownloadTask];
}

@end
