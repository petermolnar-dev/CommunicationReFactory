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
//1
#import "PMODownloadNotifications.h"

#define CLASS_NAME NSStringFromClass([self class])
#define INIT_EXCEPTION_MESSAGE [NSString stringWithFormat:@"Use [[%@ alloc] initWithPictureURL:]",CLASS_NAME]

@interface PMOPictureController()

/**
 Our private data class, storing and hiding the information.
 */
@property (strong, nonatomic, nullable) PMOPictureWithURL *pictureWithUrl;

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
    [self addObserverForDownloadTask];
    PMODownloader *downloader = [[PMODownloader alloc] init];
    [downloader downloadDataFromURL:self.pictureWithUrl.imageURL];
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

//4
#pragma mark - Notification Center helpers
- (void)addObserverForDownloadTask {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didImageDownloaded:)
                                                 name:PMODownloadWasSuccessful
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didImageDownloadFailed)
                                                 name:PMODownloadFailed
                                               object:nil];
    
}

- (void)removeObserverForDownloadTask {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//5
#pragma mark - Dealloc
- (void)dealloc {
    [self removeObserverForDownloadTask];
}

@end
