//
//  SRCpuMonitor.m
//  v6cn-iPhone
//
//  Created by Boris on 2023/6/20.
//  Copyright © 2023 Darcy Niu. All rights reserved.
//  [cpu监控]

#import "SRCpuMonitor.h"
#import <mach/mach.h>
#import <sys/sysctl.h>
#import <execinfo.h>

@interface SRCpuMonitor ()

@end

@implementation SRCpuMonitor

+ (instancetype)Monitor {
    
    static SRCpuMonitor *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SRCpuMonitor alloc] init];
    });
    return instance;
}

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
    
    }
    return self;
}

- (void)getCurrentCpuUsage:(SRCpuUsageBlock)complete {
    
    CGFloat currentUsage = 0;
    currentUsage = [self cpuUsage];
    
    if (complete) {
        complete(currentUsage);
    }
}
- (void)getCurrentBackTrace:(SRBackTraceBlock)complete {
    
    NSArray *currentBackTrace = @[];
    id data = [self backtrace];
    if (data && [data isKindOfClass:[NSArray class]]) {
        currentBackTrace = data;
    }
    if (complete) {
        complete(currentBackTrace);
    }
}
#pragma mark - 获取当前cpu使用率...
- (float)cpuUsage {
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;

    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }

    task_basic_info_t basic_info;
    thread_array_t thread_list;
    mach_msg_type_number_t thread_count;

    thread_info_data_t thinfo;
    mach_msg_type_number_t thread_info_count;

    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0; // Mach threads

    basic_info = (task_basic_info_t)tinfo;

    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    if (thread_count > 0) {
        stat_thread += thread_count;
    }

    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;

    for (j = 0; j < thread_count; j++) {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }

        basic_info_th = (thread_basic_info_t)thinfo;

        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }

    } // for each thread

    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);

    return tot_cpu;
}
#pragma mark - 获取当前堆栈信息...
- (NSArray *)backtrace {
    void *callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);

    NSMutableArray *backtraceArray = [NSMutableArray arrayWithCapacity:frames];
    for (int i = 0; i < frames; i++) {
        [backtraceArray addObject:[NSString stringWithUTF8String:strs[i]]];
    }

    free(strs);
    
    return backtraceArray;
}


@end
