//
//  PMODataHolder.h
//  CommunicationReFactory
//
//  Created by Peter Molnar on 14/12/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PMODataHolder <NSObject>

/**
 Our delegate, which will do the actual download for us.
 */
@property (strong, nonatomic, nullable) id <PMODownloaderFromURL> delegate;

/**
 Completion handler. Call with the downloada data as NSData when the download of the data completed.

 @param data The downloaded data is raw NSData format.
 */
- (void)didDownloadedData:(NSData *) data;

@end
