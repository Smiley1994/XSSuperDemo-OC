//
//  SMLagMonitor.m
//  XSSuperDemo-OC
//
//  Created by GoodMorning on 2023/8/29.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import "SMLagMonitor.h"

@interface SMLagMonitor(){
    int timeoutCount;
    CFRunLoopObserverRef runLoopObserver;
    @public
    dispatch_semaphore_t dispatchSemaphore;
    CFRunLoopActivity runloopActivity;
}

@property (nonatomic, strong) NSTimer * cpuMonitorTimer;

@end

@implementation SMLagMonitor

+ (instancetype)shareInstance {
    static id instance = nil;
    static dispatch_once_t dispatchOnce;
    dispatch_once(&dispatchOnce, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)beginMonitor {
    
    if (runLoopObserver){
        return;
    }
    
    dispatchSemaphore = dispatch_semaphore_create(0);
    CFRunLoopObserverContext context = {0,(__bridge void *)self,NULL,NULL};
    runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runloopObserverCallBack, &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), runLoopObserver, kCFRunLoopCommonModes);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
      // 在子线程执行一个死循环去轮询检测当前信号量的状态
      // 在runloop的监听函数里面我们设置了当runloop的状态发生变化的时候信号量就会发生减一变化.如果在信号量发生减一变化之前就已经超时了,就记录下来注册卡顿执行.至于卡顿的标准我们设置为50ms.
        while (YES) {
            //dispatch_semaphore_wait方法如果超时则会返回一个不等于0的整数，收到dispatch_semaphore_signal的时候会返回0
            long semaphoreWait = dispatch_semaphore_wait(self->dispatchSemaphore, dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC));
            if (semaphoreWait != 0){
                if (!self->runLoopObserver){
                    self->timeoutCount = 0;
                    self->dispatchSemaphore = 0;
                    self->runloopActivity = 0;
                    return ;
                }
                //BeforeSource和AfterWaiting这两个状态区间能够监测到是否卡顿
                if (self->runloopActivity == kCFRunLoopBeforeSources || self->runloopActivity == kCFRunLoopAfterWaiting){
                    // 如果卡顿次数没有超出阈值,就只做记录不做上报.
                    if (self->timeoutCount++ < 5) {
                        continue;
                    }
                    NSLog(@"monitor trigger");
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                        //上报堆栈
                        // ...
                    });
                }
            }
            self->timeoutCount = 0;
        }
    });
    
}

static void runloopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void * info){
    SMLagMonitor *lagMonitor = (__bridge SMLagMonitor *)info;
    lagMonitor->runloopActivity = activity;
    dispatch_semaphore_t semaphore = lagMonitor->dispatchSemaphore;
    dispatch_semaphore_signal(semaphore);
}

@end
