//
//  SRDelayedBlockHandle.h
//  v6cn-iPhone
//
//  Created by Xiaosong on 2023/6/30.
//  Copyright © 2023 Darcy Niu. All rights reserved.
//

// dispatch_after 可取消延迟执行 工具

#ifndef SRDelayedBlockHandle_h
#define SRDelayedBlockHandle_h

typedef void(^SRDelayedBlockHandle)(BOOL cancel);

//static void cancel_delayed_block(SRDelayedBlockHandle delayedHandle) {
//    if (nil == delayedHandle) {
//        return;
//    }
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        delayedHandle(YES);
//    });
//}

static SRDelayedBlockHandle perform_block_after_delay(CGFloat seconds, dispatch_block_t block) {
    if (block == nil) {
        return nil;
    }
    
    __block dispatch_block_t blockToExecute = [block copy];
    __block SRDelayedBlockHandle delayHandleCopy = nil;
    
    SRDelayedBlockHandle delayHandle = ^(BOOL cancel) {
        if (!cancel && blockToExecute) {
            blockToExecute();
        }
        
        // Once the handle block is executed, canceled or not, we free blockToExecute and the handle.
        // Doing this here means that if the block is canceled, we aren't holding onto retained objects for any longer than necessary.
#if !__has_feature(objc_arc)
        [blockToExecute release];
        [delayHandleCopy release];
#endif
        
        blockToExecute = nil;
        delayHandleCopy = nil;
    };
    // delayHandle also needs to be moved to the heap.
    delayHandleCopy = [delayHandle copy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (nil != delayHandleCopy) {
            delayHandleCopy(NO);
        }
    });
    
    return delayHandleCopy;
}

#endif /* SRDelayedBlockHandle_h */
