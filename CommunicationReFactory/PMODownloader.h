//
//  PMODownloader.h
//  CommunicationReFactory
//
//  Created by Peter Molnar on 03/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
//1
#import "PMODownloaderFromURL.h"

//2
@interface PMODownloader : NSObject <PMODownloaderFromURL>

/**
 Property to store the downloaded data in NSData format
 */
@property (strong, nonatomic, nullable) NSData *downloadedData;


@end
