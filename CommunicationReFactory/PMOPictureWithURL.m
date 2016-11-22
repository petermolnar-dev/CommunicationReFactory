//
//  PMOPictureWithURL.m
//  CommunicationReFactory
//
//  Created by Peter Molnar on 30/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOPictureWithURL.h"

//1
#define CLASS_NAME NSStringFromClass([self class])
#define INIT_EXCEPTION_MESSAGE [NSString stringWithFormat:@"Use [[%@ alloc] initWithPictureURL:]",CLASS_NAME]

@implementation PMOPictureWithURL

#pragma mark - Initializers 
- (instancetype)initWithPictureURL:(NSURL *)url {
    if (url) {
        self = [super init];
        if (self) {
            _imageURL = url;
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

@end
