//
//  PMOPictureWithURL.h
//  CommunicationReFactory
//
//  Created by Peter Molnar on 30/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
  An example class for storing a downloaded image and it URL.
 */
@interface PMOPictureWithURL : NSObject

/**
 The stored image
 */
@property (strong, nonatomic, nullable) UIImage *image;

/**
 The url of the image
 */
@property (strong, nonatomic, nonnull) NSURL *imageURL;


/**
 Designated initializer

 @param url Full url for the picture

 @return Instance of PMOPictureWithURL
 */
- (nonnull instancetype)initWithPictureURL:(nonnull NSURL *)url NS_DESIGNATED_INITIALIZER;

/**
 Removing the default initializer

 @return nil
 */
- (nullable instancetype)init NS_UNAVAILABLE;

@end
