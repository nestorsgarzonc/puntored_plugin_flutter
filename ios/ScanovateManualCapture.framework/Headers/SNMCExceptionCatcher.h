//
//  SNMCExceptionCatcher.h
//  LivnessNewGUIBuild2
//
//  Created by Nimrod Borochov on 23/12/2019.
//  Copyright © 2019 Scanovate. All rights reserved.
//

#ifndef SNMCExceptionCatcher_h
#define SNMCExceptionCatcher_h
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

#endif /* SNMCExceptionCatcher_h */
