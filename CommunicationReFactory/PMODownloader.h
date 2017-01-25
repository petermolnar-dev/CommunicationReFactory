//
//  PMODownloader.h
//  CommunicationReFactory
//
//  Created by Peter Molnar on 03/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMODownloader : NSObject

//1
/**
 The download method, which triggers the download from the parameter url, and executes the passed block in case of the succesful download.
 
 @param url the URL of the downloadable resource
 @param callback the callback block, which will be executed with succesfull download
 */
- (void)downloadDataFromURL:(nonnull NSURL *)url completionHander:(void(^_Nonnull)(NSData * _Nullable downloadedData))callback;

@end
