//
//  XSLiveRoomViewController.m
//  XSSuperDemo-OC
//
//  Created by GoodMorning on 2023/8/5.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import "XSLiveRoomViewController.h"

// liveroom module
#import "XSLiveRoomServerProtocol.h"
#import "XSLiveRoomViewController.h"

#import "XSVideoCapture.h"
#import "XSVideoEncoder.h"
#import "XSVideoDecoder.h"
#import "MetalPlayer.h"

#import "XSAudioCapture.h"

//
#import "Beehive.h"

#import <AVFoundation/AVFoundation.h>

@interface XSLiveRoomViewController () <XSLiveRoomServerProtocol, XSVideoCapturerDelegate, XSVideoEncoderDelegate, XSVideoDecoderDelegate, UIViewControllerTransitioningDelegate>

/// 视频采集器
@property (nonatomic, strong) XSVideoCapture *videoCapture;

/// 视频采集预览视图
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoCapturePreviewLayer;

/// 视频编码器
@property (nonatomic, strong) XSVideoEncoder *videoEncoder;

/// 解码器
@property (nonatomic, strong) XSVideoDecoder *videoDecoder;

/// 视频流播放器
@property (nonatomic, strong) MetalPlayer *playLayer;

/// 语音采集器
@property (nonatomic, strong) XSAudioCapture *audioCapture;

@end


@BeeHiveService(XSLiveRoomServerProtocol, XSLiveRoomViewController)
@implementation XSLiveRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self createMediaCapture];
    
}

- (void)setupUI {
    
//    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}

- (void)createMediaCapture {
    
    // 初始化视频采集
    XSVideoCapturerParam *param = [[XSVideoCapturerParam alloc] init];
    param.sessionPreset = AVCaptureSessionPreset1280x720;
    
    self.videoCapture = [[XSVideoCapture alloc] initWithCaptureParam:param error:nil];
    self.videoCapture.delegate = self;
    
    CGFloat layerX = 15;
    CGFloat layerY = 120;
    CGFloat layerW = (self.view.frame.size.width - layerX * 3) * 0.5;
    CGFloat layerH = layerW * 16 / 9.00;
    
    // 初始化视频采集的预览画面
    self.videoCapturePreviewLayer = self.videoCapture.videoPreviewLayer;
    self.videoCapturePreviewLayer.frame = CGRectMake(layerX, layerY, layerW, layerH);
    
    // 初始化并开启视频编码
    XSVideoEncoderParam *encodeParam = [[XSVideoEncoderParam alloc] init];
    encodeParam.encodeType = kCMVideoCodecType_H264;
    encodeParam.encodeWidth = 180;
    encodeParam.encodeHeight = 320;
    encodeParam.bitRate = 512 * 1024;
    self.videoEncoder = [[XSVideoEncoder alloc] initWithParam:encodeParam];
    self.videoEncoder.delegate = self;
    [self.videoEncoder startVideoEncode];

    // 初始化视频解码
    self.videoDecoder = [[XSVideoDecoder alloc] init];
    self.videoDecoder.delegate = self;

    // 初始化视频编码解码后的播放画面
    self.playLayer = [[MetalPlayer alloc] initWithFrame:CGRectMake(layerX * 2 + layerW, layerY, layerW, layerH)];
    self.playLayer.backgroundColor = [UIColor blackColor].CGColor;
    
    CGFloat buttonW = self.view.frame.size.width * 0.4;
    CGFloat buttonH = 40;
    CGFloat buttonMargin = (self.view.frame.size.width - buttonW * 2) / 3.0;
    CGFloat buttonY = CGRectGetMaxY(self.videoCapturePreviewLayer.frame) + 40;
    
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonMargin, buttonY, buttonW, buttonH)];
    [cameraButton setTitle:@"开启/关闭 摄像头" forState:UIControlStateNormal];
    [cameraButton setBackgroundColor:[UIColor lightGrayColor]];
    [cameraButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(cameraButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
    
    UIButton *revertCameraButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonMargin * 2 + buttonW, buttonY, buttonW, buttonH)];
    [revertCameraButton setTitle:@"切换摄像头" forState:UIControlStateNormal];
    [revertCameraButton setBackgroundColor:[UIColor lightGrayColor]];
    [revertCameraButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [revertCameraButton addTarget:self action:@selector(revertCameraButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:revertCameraButton];
    
    
    XSAudioCapturerParam *audioCapture = [[XSAudioCapturerParam alloc] init];
    self.audioCapture = [[XSAudioCapture alloc] initWithCapturerParam:audioCapture];
    
//    __weak typeof(self) weakSelf = self;
    self.audioCapture.errorCallBack = ^(NSError * _Nonnull error) {
        
        
    };
    
    self.audioCapture.sampleBufferOutputCallBack = ^(CMSampleBufferRef  _Nonnull sample) {
      
        CMFormatDescriptionRef formatDescription = CMSampleBufferGetFormatDescription(sample);
        if (formatDescription) {
            const AudioStreamBasicDescription *audioDescription = CMAudioFormatDescriptionGetStreamBasicDescription(formatDescription);
            if (audioDescription) {
                // 可以从 audioDescription 中获取音频的相关信息，如采样率、声道数、位深度等
                Float64 sampleRate = audioDescription->mSampleRate;
                UInt32 numberOfChannels = audioDescription->mChannelsPerFrame;
                // ...
                NSLog(@"sampleRate == %f \n numberOfChannels == %u",sampleRate, (unsigned int)numberOfChannels);
            }
        }
        
    };
    
    UIButton *startCaptureAudioButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonMargin, buttonY + 60, buttonW, buttonH)];
    [startCaptureAudioButton setTitle:@"开始录音" forState:UIControlStateNormal];
    [startCaptureAudioButton setBackgroundColor:[UIColor lightGrayColor]];
    [startCaptureAudioButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startCaptureAudioButton addTarget:self action:@selector(startCaptureAudioAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startCaptureAudioButton];
    
    UIButton *stopCaptureAudioButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonMargin * 2 + buttonW, buttonY + 60, buttonW, buttonH)];
    [stopCaptureAudioButton setTitle:@"停止录音" forState:UIControlStateNormal];
    [stopCaptureAudioButton setBackgroundColor:[UIColor lightGrayColor]];
    [stopCaptureAudioButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [stopCaptureAudioButton addTarget:self action:@selector(stopCaptureAudioAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopCaptureAudioButton];
    
    
}

- (void)cameraButtonAction:(UIButton *)button {
    
    button.selected = !button.selected;
    
    if (button.selected) {
        
        [self.videoCapture startCapture];
        
        [self.view.layer addSublayer:self.videoCapturePreviewLayer];
        [self.view.layer addSublayer:self.playLayer];
        
    } else {
        
        [self.videoCapture stopCapture];
        [self.videoCapture.videoPreviewLayer removeFromSuperlayer];
        [self.playLayer removeFromSuperlayer];
        
    }
}

- (void)revertCameraButtonAction:(UIButton *)button {
   
    [self.videoCapture reverseCamera];
    
}

- (void)startCaptureAudioAction {
    
    [self.audioCapture startCapture];
    
}

- (void)stopCaptureAudioAction {
    
    [self.audioCapture stopCapture];
    
}

#pragma mark - capture output datas
- (void)videoCaptureOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    
    [self.videoEncoder videoEncodeInputSampleBuffer:sampleBuffer forceKeyFrame:NO];
    
}

#pragma mark - encoder
- (void)videoEncodeOutputData:(NSData *)data isKeyFrame:(BOOL)isKeyFrame {
    
    [self.videoDecoder decodeH264NaluData:data];
    
}

#pragma mark - decoder
- (void)videoH264DecodeOutputData:(CVImageBufferRef)imageBuffer {
    
    [self.playLayer inputPixelBuffer:imageBuffer];
    CVPixelBufferRelease(imageBuffer);
    
}

- (void)videoH265DecodeOutputData:(CVImageBufferRef)imageBuffer {
    
    [self.playLayer inputPixelBuffer:imageBuffer];
    CVPixelBufferRelease(imageBuffer);
    
    
}


@end
