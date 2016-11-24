//
//  PMODownloader.h
//  CommunicationReFactory
//
//  Created by Peter Molnar on 03/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMODownloader : NSObject


/**
 Property to store the downloaded data in NSData format
 */
@property (strong, nonatomic) NSData *downloadedData;
/**
 Downloading and giving back the raw data result from the url. 

 @param url the source url
 */
- (void)downloadDataFromURL:(NSURL *)url;

@end
