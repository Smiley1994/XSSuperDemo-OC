//
//  XSAudioEncoder.h
//  XSSuperDemo-OC
//
//  Created by GoodMorning on 2023/8/14.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>

NS_ASSUME_NONNULL_BEGIN

#define NOW (CACurrentMediaTime()*1000)

typedef NS_ENUM (NSUInteger, XSAudioBitRate) {
    XSAudioBitRate_32Kbps = 32000,
    XSAudioBitRate_64Kbps = 64000,
    XSAudioBitRate_96Kbps = 96000,
    XSAudioBitRate_128Kbps = 128000,
    XSAudioBitRate_Default = XSAudioBitRate_96Kbps
};
typedef NS_ENUM (NSUInteger, XSAudioSampleRate){
    XSAudioSampleRate_16000Hz = 16000,
    XSAudioSampleRate_44100Hz = 44100,
    XSAudioSampleRate_48000Hz = 48000,
    XSAudioSampleRate_Default = XSAudioSampleRate_44100Hz
};
typedef NS_ENUM (NSUInteger, XSAudioQuality){
    XSAudioQuality_Low = 0,
    XSAudioQuality_Medium = 1,
    XSAudioQuality_High = 2,
    XSAudioQuality_VeryHigh = 3,
    XSAudioQuality_Default = XSAudioQuality_VeryHigh
};

@interface XSAudioEncoderParam : NSObject

@property (nonatomic, assign) NSUInteger numberOfChannels;

/// 采样率 单位 Hz
@property (nonatomic, assign) XSAudioSampleRate audioSampleRate;
/// 码率 单位 kbps
@property (nonatomic, assign) XSAudioBitRate audioBitrate;

@property (nonatomic, assign, readonly) char *asc;

@property (nonatomic, assign, readonly) NSUInteger bufferLength;

@end


@protocol XSAudioEncoderDelegate <NSObject>

/// 编码输出数据
/// @param audioData 输出数据
//- (void)encodeAudioData:(nullable NSData*)audioData timeStamp:(uint64_t)timeStamp;

/// 编码输出数据
/// @param sampleBufferRef 输出数据
/// @param timeStamp 时间戳
- (void)audioEncoderSampleBufferRef:(nullable CMSampleBufferRef)sampleBufferRef timeStamp:(uint64_t)timeStamp;

//- (void)stopEncoder;

@end

@interface XSAudioEncoder : NSObject

/// 音频编码码率。
@property (nonatomic, strong) XSAudioEncoderParam *audioEncodeParam;
/// 音频编码数据回调。
@property (nonatomic, copy) void (^sampleBufferOutputCallBack)(CMSampleBufferRef sample);
/// 音频编码错误回调。
@property (nonatomic, copy) void (^errorCallBack)(NSError *error);

@property (nonatomic, weak) id<XSAudioEncoderDelegate> delegate;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithAudioEncoderParam:(XSAudioEncoderParam *)param;

/// 编码
- (void)encodeSampleBuffer:(CMSampleBufferRef)buffer timeStamp:(uint64_t)timeStamp;

@end

NS_ASSUME_NONNULL_END
