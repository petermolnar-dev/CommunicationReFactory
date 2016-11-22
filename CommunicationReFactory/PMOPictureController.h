//
//  PMOPictureController.h
//  CommunicationReFactory
//
//  Created by Peter Molnar on 03/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PMOPictureController : NSObject


/**
 The designated initializer, the picture's url is mandatory to pass.

 @param url The picture full url, as NSURL

 @return An instance PMOPictureController.
 */
- (nonnull instancetype)initWithPictureURL:(nonnull NSURL *)url NS_DESIGNATED_INITIALIZER;


/**
 Start the asynchron download of the image.
 */
- (void)downloadImage;

/**
 A high level, public API function to retrieve the image as UIImage

 @return an instance of UIImage.
 */
- (nullable UIImage *)image;

@end
