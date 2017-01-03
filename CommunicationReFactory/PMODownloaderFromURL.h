//
//  PMODownloaderFromURL.h
//  CommunicationReFactory
//
//  Created by Peter Molnar on 14/12/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMODataHolder.h"


/**
 Forward declaration of the used and referenced protocol
 */
@protocol PMODataHolder;

@protocol PMODownloaderFromURL <NSObject>

/**
 A weak pointer, pointing back to the original caller. We can do a callback message sending via this, when the async download finished.
 */
@property (weak, nonatomic, nullable) id <PMODataHolder> receiver;


/**
 A general downloader method, which is required to implement.

 @param url The url of the source file.
 */
- (void)downloadDataFromURL:(nonnull NSURL *)url;


/**
 the callback wrapper/ complition handler. In this method the downloaded raw NSData needs to be handed over the receiver.

 @param data The downloaded raw data in NSData format.
 */
- (void)handOverDownloadedDataToReceiver:(nullable NSData *)data;

@end
