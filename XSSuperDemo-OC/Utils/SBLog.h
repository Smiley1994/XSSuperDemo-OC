//
//  ZGLog.h
//  iosapp
//
//  Created by Zhugeio on 15/10/23.
//  Copyright © 2015年 oschina. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <asl.h>
#import <pthread.h>
#import <os/log.h>

static inline os_log_t shadowBaseLog() {
    static os_log_t logger = nil;
    if (!logger) {
        if (@available(iOS 10.0, macOS 10.12, *)) {
            logger = os_log_create("com.shadowbase.sdk.ios", "ShadowBase");
        }
    }
    return logger;
}


static inline void SBLogDebug(NSString *format, ...) {
    
    va_list arg_list;
    va_start(arg_list, format);
    NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:arg_list];
    if (@available(iOS 10.0, macOS 10.12, *)) {
        os_log_with_type(shadowBaseLog(), OS_LOG_TYPE_DEBUG, "<Debug>: %s", [formattedString UTF8String]);
    }
    else {
        NSLog(@"[ShadowBase]: %@", formattedString);
    }
}

static inline void SBLogInfo(NSString *format, ...) {

    va_list arg_list;
    va_start(arg_list, format);
    NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:arg_list];
    if (@available(iOS 10.0, macOS 10.12, *)) {
        os_log_with_type(shadowBaseLog(), OS_LOG_TYPE_INFO, "<Info>: %s", [formattedString UTF8String]);
    }
    else {
        NSLog(@"[ShadowBase]: %@", formattedString);
    }
}

static inline void SBLogWarning(NSString *format, ...) {

    va_list arg_list;
    va_start(arg_list, format);
    NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:arg_list];
    if (@available(iOS 10.0, macOS 10.12, *)) {
        os_log_with_type(shadowBaseLog(), OS_LOG_TYPE_ERROR, "<Warning>: %s", [formattedString UTF8String]);
    }
    else {
        NSLog(@"[ShadowBase]: %@", formattedString);
    }
}

static inline void SBLogError(NSString *format, ...) {
    va_list arg_list;
    va_start(arg_list, format);
    NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:arg_list];
    if (@available(iOS 10.0, macOS 10.12, *)) {
        os_log_with_type(shadowBaseLog(), OS_LOG_TYPE_ERROR, "<Error>: %s", [formattedString UTF8String]);
    }
    else {
        NSLog(@"[ShadowBase]: %@", formattedString);
    }
}


