//
//  XSVideoCapture.h
//  XSSuperDemo-OC
//
//  Created by GoodMorning on 2023/8/8.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XSVideoCapturerDelegate <NSObject>

/// 开始采集
- (void)startVideoCapture;

/// 停止采集
- (void)stopVideoCapture;

/// 摄像头采集数据输出
/// @param sampleBuffer 采集的数据
- (void)videoCaptureOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer;


@end

@interface XSVideoCapturerParam : NSObject

/// 摄像头位置，默认为前置摄像头AVCaptureDevicePositionFront
@property (nonatomic, assign) AVCaptureDevicePosition devicePosition;

/// 视频分辨率 默认AVCaptureSessionPreset1280x720
@property (nonatomic, assign) AVCaptureSessionPreset sessionPreset;

/// 帧率 单位为 帧/秒, 默认为15帧/秒
@property (nonatomic, assign) NSInteger frameRate;

/// 摄像头方向 默认为当前手机屏幕方向
@property (nonatomic, assign) AVCaptureVideoOrientation videoOrientation;

@end


@interface XSVideoCapture : NSObject

/// 预览图层，把这个图层加在View上并且为这个图层设置frame就能播放
@property (nonatomic, strong, readonly) AVCaptureVideoPreviewLayer *videoPreviewLayer;

/// 视频采集参数
@property (nonatomic, strong) XSVideoCapturerParam *captureParam;

/// 代理
@property (nonatomic, weak) id<XSVideoCapturerDelegate> delegate;

/// 初始化方法
/// @param param 参数
/// @param error 报错信息
- (instancetype)initWithCaptureParam:(XSVideoCapturerParam *)param error:(NSError **)error;

/// 开始采集
- (NSError *)startCapture;

/// 停止采集
- (NSError *)stopCapture;

/// 抓图 block 返回 UIImage
- (void)imageCapture:(void(^)(UIImage *image))completion;

/// 动态调整帧率
- (NSError *)adjustFrameRate:(NSInteger)frameRate;

/// 翻转摄像头
- (NSError *)reverseCamera;

/// 采集过程中动态修改视频分辨率
- (void)changeSessionPreset:(AVCaptureSessionPreset)sessionPreset;

@end

NS_ASSUME_NONNULL_END
