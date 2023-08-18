//
//  XSAudioCapture.h
//  XSSuperDemo-OC
//
//  Created by GoodMorning on 2023/8/14.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XSAudioCapturerDelegate <NSObject>

/// 开始采集
@optional
- (void)startAudioCapture;

/// 停止采集
@optional
- (void)stopAudioCapture;

/// 摄像头采集数据输出
/// @param sampleBuffer 采集的数据
- (void)audioCaptureOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer;


@end

@interface XSAudioCapturerParam : NSObject

// 声道数，default: 2
@property (nonatomic, assign) NSUInteger channels;
// 采样率，default: 44100
@property (nonatomic, assign) NSUInteger sampleRate;
// 量化位深，default: 16
@property (nonatomic, assign) NSUInteger bitDepth;

@end

@interface XSAudioCapture : NSObject

/// CapturerParam
@property (nonatomic, strong, readonly) XSAudioCapturerParam *capturerParam;
/// 音频采集数据回调
@property (nonatomic, copy) void (^sampleBufferOutputCallBack)(CMSampleBufferRef sample);
/// 音频采集错误回调
@property (nonatomic, copy) void (^errorCallBack)(NSError *error);

/// 代理
@property (nonatomic, weak) id<XSAudioCapturerDelegate> delegate;

#pragma mark - Initializer
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithCapturerParam:(XSAudioCapturerParam *)param NS_DESIGNATED_INITIALIZER;

/// 开始采集音频数据。
- (void)startCapture;
// 停止采集音频数据。
- (void)stopCapture;

@end

NS_ASSUME_NONNULL_END
