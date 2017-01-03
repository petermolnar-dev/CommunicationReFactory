//
//  PMODataHolder.h
//  CommunicationReFactory
//
//  Created by Peter Molnar on 14/12/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMODownloaderFromURL.h"

/**
 Forward declaration of the used and referenced protocol
 */
@protocol PMODownloaderFromURL;


@protocol PMODataHolder <NSObject>

/**
 Our delegate, which will do the actual download for us.
 */
@property (strong, nonatomic, nullable) id <PMODownloaderFromURL> delegate;

/**
 Completion handler. Call with the downloada data as NSData when the download of the data completed.

 @param data The downloaded data is raw NSData format.
 */
- (void)didDownloadedData:(nullable NSData *) data;

@end
