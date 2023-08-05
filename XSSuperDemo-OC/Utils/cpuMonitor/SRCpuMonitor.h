//
//  SRCpuMonitor.h
//  v6cn-iPhone
//
//  Created by Boris on 2023/6/20.
//  Copyright © 2023 Darcy Niu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRCpuMonitor : NSObject

+ (instancetype)Monitor;

typedef void (^SRCpuUsageBlock)(CGFloat cpuRatio);
@property (nonatomic, copy) SRCpuUsageBlock cpuUseBlock;

typedef void (^SRBackTraceBlock)(NSArray *backTrace);
@property (nonatomic, copy) SRBackTraceBlock backTraceBlock;

// 获取当前使用率,请勿频繁调用...
- (void)getCurrentCpuUsage:(SRCpuUsageBlock)complete;

/**
 获取当前堆栈信息,请勿频繁调用...
 可在 applicationWillTerminate 中调用此方法并上传当前日志...
 */
- (void)getCurrentBackTrace:(SRBackTraceBlock)complete;

@end

NS_ASSUME_NONNULL_END
