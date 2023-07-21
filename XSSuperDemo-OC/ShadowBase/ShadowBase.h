//
//  ShadowBase.h
//  XSSuperDemo-OC
//
//  Created by Macrolor  on 2021/9/8.
//  Copyright © 2021 GoodMorning. All rights reserved.
//

/**
 * 埋点工具
 *
 */

#import <Foundation/Foundation.h>
#import "ShadowBaseConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShadowBase : NSObject

/**
 * 获取 ShadowBase 的实例。
 */
+ (ShadowBase *)shareInstance;

- (ShadowBaseConfig *)config;

/**
 开启 ShadowBase 统计。
 @param appKey 应用的 Key
 @param launchOptions 启动项
 */
- (void)startWithAppKey:(NSString*)appKey launchOptions:(NSDictionary*)launchOptions;



- (void)enableExceptionTrack;

/**
 * 追踪自定义事件。
 * @param event      事件名称
 */
- (void)track:(NSString *)event;

/**
 * 追踪自定义事件。
 * @param event      事件名称
 * @param properties 事件属性
 */
- (void)track:(NSString *)event properties:(NSDictionary *)properties;

/**
 * @param properties 全埋点属性
 */
- (void)autoTrack:(NSDictionary *)properties;

/**
 * @param exception 抛出的异常
 */
- (void)trackException:(NSException *)exception;

/**
 * 将信息写入日志系统。
 * @param message   需写入的信息
 */
- (void)writeLogWithMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
