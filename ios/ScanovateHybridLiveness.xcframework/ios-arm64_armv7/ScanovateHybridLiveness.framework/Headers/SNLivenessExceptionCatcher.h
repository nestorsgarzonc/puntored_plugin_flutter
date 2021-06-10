//
//  SNExceptionCatcher.h
//  LivnessNewGUIBuild2
//
//  Created by Nimrod Borochov on 23/12/2019.
//  Copyright © 2019 Scanovate. All rights reserved.
//

#ifndef SNLivenessExceptionCatcher_h
#define SNLivenessExceptionCatcher_h
#import <Foundation/Foundation.h>

NS_INLINE NSException * _Nullable tryBlock(void(^_Nonnull tryBlock)(void)) {
    @try {
        tryBlock();
    }
    @catch (NSException *exception) {
        return exception;
    }
    return nil;
}

#endif /* SNLivenessExceptionCatcher_h */
