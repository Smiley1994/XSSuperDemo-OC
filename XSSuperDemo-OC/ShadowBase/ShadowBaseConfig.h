//
//  ShadowBaseConfig.h
//  XSSuperDemo-OC
//
//  Created by Macrolor on 2021/9/8.
//  Copyright © 2021 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/* SDK版本 */
#define SB_SDK_VERSION @"0.0.1"

@interface ShadowBaseConfig : NSObject

#pragma mark - 基本设置

// SDK版本
@property (nonatomic, copy) NSString *sdkVersion;

// 应用版本(默认:info.plist中CFBundleShortVersionString对应的值)
@property (nonatomic, copy) NSString *appVersion;

//应用名称（默认：info.plist中的CFBundleDisplayName）
@property (nonatomic, copy)NSString *appName;

// 渠道(默认:@"App Store")
@property (nonatomic, copy) NSString *channel;

// 两次会话时间间隔(默认:30秒)
@property (nonatomic, assign) NSUInteger sessionInterval;


#pragma mark - 发送策略

// 上报时间间隔(默认:10秒)
@property  NSUInteger sendInterval;

// 每天最大上报事件数，超出部分缓存到本地(默认:50000个)
@property (nonatomic, assign) NSUInteger sendMaxSizePerDay;

// 本地缓存事件数(默认:50000个)
@property (nonatomic, assign) NSUInteger cacheMaxSize;


/**
 * Crash 信息采集是否开启
 * 默认 NO
 */
@property (nonatomic,assign) BOOL isEnableExceptionTrack;

/**
 * 全埋点是否开启
 * 默认NO
 */
@property (nonatomic,assign) BOOL enableAutoTrack;

/**
 * log 日志 开关  （ 请在debug 模式下 使用 ！！！！）
 */
@property (nonatomic, assign) BOOL enableLoger;

@end

NS_ASSUME_NONNULL_END
