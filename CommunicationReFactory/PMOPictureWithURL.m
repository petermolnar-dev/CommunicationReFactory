//
//  PMOPictureWithURL.m
//  CommunicationReFactory
//
//  Created by Peter Molnar on 30/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOPictureWithURL.h"


@implementation PMOPictureWithURL

#pragma mark - Initializers
- (instancetype)initWithPictureURL:(NSURL *)url {
    self = [super init];
    if (self) {
        _imageURL = url;
    }
    return self;
}


@end
