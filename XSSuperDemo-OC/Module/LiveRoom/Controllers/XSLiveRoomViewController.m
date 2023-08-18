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
#import "XSAudioEncoder.h"

//
#import "Beehive.h"

#import <AVFoundation/AVFoundation.h>

@interface XSLiveRoomViewController () <XSLiveRoomServerProtocol, XSVideoCapturerDelegate, XSVideoEncoderDelegate, XSVideoDecoderDelegate, XSAudioCapturerDelegate, XSAudioEncoderDelegate, UIViewControllerTransitioningDelegate>

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

///  语音编码器
@property (nonatomic, strong) XSAudioEncoder *audioEncoder;

@property (nonatomic, strong) NSFileHandle *fileHandle;

@end


@BeeHiveService(XSLiveRoomServerProtocol, XSLiveRoomViewController)
@implementation XSLiveRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupAudioSession];
    
    [self createMediaCapture];
    
}

- (void)setupUI {
    
//    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)createMediaCapture {
    
    // =========== 视频频
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
    
    // =========== 音频
    
    XSAudioCapturerParam *audioCapture = [[XSAudioCapturerParam alloc] init];
    self.audioCapture = [[XSAudioCapture alloc] initWithCapturerParam:audioCapture];
    self.audioCapture.delegate = self;
//    __weak typeof(self) weakSelf = self;
//    self.audioCapture.errorCallBack = ^(NSError * _Nonnull error) {
//    };
//    self.audioCapture.sampleBufferOutputCallBack = ^(CMSampleBufferRef  _Nonnull sample) {
//    };
    
    XSAudioEncoderParam *audioEncoderParam = [[XSAudioEncoderParam alloc] init];
    self.audioEncoder = [[XSAudioEncoder alloc] initWithAudioEncoderParam:audioEncoderParam];
    self.audioEncoder.delegate = self;
    
    
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

- (void)setupAudioSession {
    NSError *error = nil;
    
    // 1、获取音频会话实例。
    AVAudioSession *session = [AVAudioSession sharedInstance];

    // 2、设置分类和选项。
    [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionMixWithOthers | AVAudioSessionCategoryOptionDefaultToSpeaker error:&error];
    if (error) {
        NSLog(@"AVAudioSession setCategory error.");
        error = nil;
        return;
    }
    
    // 3、设置模式。
    [session setMode:AVAudioSessionModeVideoRecording error:&error];
    if (error) {
        NSLog(@"AVAudioSession setMode error.");
        error = nil;
        return;
    }

    // 4、激活会话。
    [session setActive:YES error:&error];
    if (error) {
        NSLog(@"AVAudioSession setActive error.");
        error = nil;
        return;
    }
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

- (void)audioCaptureOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    
    [self.audioEncoder encodeSampleBuffer:sampleBuffer timeStamp:NOW];
    
}

#pragma mark - encoder
- (void)videoEncodeOutputData:(NSData *)data isKeyFrame:(BOOL)isKeyFrame {
    
    [self.videoDecoder decodeH264NaluData:data];
    
}

- (void)audioEncoderSampleBufferRef:(CMSampleBufferRef)sampleBufferRef timeStamp:(uint64_t)timeStamp {
    
    if (sampleBufferRef) {
        // 1、获取音频编码参数信息。
        AudioStreamBasicDescription audioFormat = *CMAudioFormatDescriptionGetStreamBasicDescription(CMSampleBufferGetFormatDescription(sampleBufferRef));
        
        // 2、获取音频编码数据。AAC 裸数据。
        CMBlockBufferRef blockBuffer = CMSampleBufferGetDataBuffer(sampleBufferRef);
        size_t totolLength;
        char *dataPointer = NULL;
        CMBlockBufferGetDataPointer(blockBuffer, 0, NULL, &totolLength, &dataPointer);
        if (totolLength == 0 || !dataPointer) {
            return;
        }
        
        // 3、在每个 AAC packet 前先写入 ADTS 头数据。
        // 由于 AAC 数据存储文件时需要在每个包（packet）前添加 ADTS 头来用于解码器解码音频流，所以这里添加一下 ADTS 头。
        [self.fileHandle writeData:[self adtsDataWithChannels:audioFormat.mChannelsPerFrame sampleRate:audioFormat.mSampleRate rawDataLength:totolLength]];
        
        // 4、写入 AAC packet 数据。
        [self.fileHandle writeData:[NSData dataWithBytes:dataPointer length:totolLength]];
        
    }
    
//    CMFormatDescriptionRef formatDescription = CMSampleBufferGetFormatDescription(sampleBufferRef);
//    if (formatDescription) {
//        const AudioStreamBasicDescription *audioDescription = CMAudioFormatDescriptionGetStreamBasicDescription(formatDescription);
//        if (audioDescription) {
//            // 可以从 audioDescription 中获取音频的相关信息，如采样率、声道数、位深度等
//            Float64 sampleRate = audioDescription->mSampleRate;
//            UInt32 numberOfChannels = audioDescription->mChannelsPerFrame;
//            // ...
//            NSLog(@"sampleRate == %f \n numberOfChannels == %u",sampleRate, (unsigned int)numberOfChannels);
//        }
//    }
    
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
///var/mobile/Containers/Data/Application/6529A31D-C054-42ED-B63E-3AB1CFF9587C/Documents/test.aac
- (NSFileHandle *)fileHandle {
    if (!_fileHandle) {
        NSString *audioPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test.aac"];
        NSLog(@"AAC file path: %@", audioPath);
        [[NSFileManager defaultManager] removeItemAtPath:audioPath error:nil];
        [[NSFileManager defaultManager] createFileAtPath:audioPath contents:nil attributes:nil];
        _fileHandle = [NSFileHandle fileHandleForWritingAtPath:audioPath];
    }

    return _fileHandle;
}

- (void)dealloc {
    
    if (self.fileHandle) {
        [self.fileHandle closeFile];
    }
}

#pragma mark --
// 按音频参数生产 AAC packet 对应的 ADTS 头数据。
// 当编码器编码的是 AAC 裸流数据时，需要在每个 AAC packet 前添加一个 ADTS 头用于解码器解码音频流。
// 参考文档：
// ADTS 格式参考：http://wiki.multimedia.cx/index.php?title=ADTS
// MPEG-4 Audio 格式参考：http://wiki.multimedia.cx/index.php?title=MPEG-4_Audio#Channel_Configurations
- (NSData *)adtsDataWithChannels:(NSInteger)channels sampleRate:(NSInteger)sampleRate rawDataLength:(NSInteger)rawDataLength {
    // 1、创建数据缓冲区。
    int adtsLength = 7; // ADTS 头固定 7 字节。
    char *packet = malloc(sizeof(char) * adtsLength);
    
    // 2、设置各数据字段。
    int profile = 2; // 2 表示 AAC LC。
    NSInteger sampleRateIndex = [self sampleRateIndex:sampleRate]; // 取得采样率对应的 index。
    int channelCfg = (int) channels; // MPEG-4 Audio Channel Configuration。
    NSUInteger fullLength = adtsLength + rawDataLength; // 这里的长度字段是：ADTS 头数据和 AAC packet 数据的总长度。
    
    //  3、填充 ADTS 数据。
    packet[0] = (char) 0xFF; // 11111111     = syncword
    packet[1] = (char) 0xF9; // 1111 1 00 1  = syncword MPEG-2 Layer CRC
    packet[2] = (char) (((profile - 1) << 6) + (sampleRateIndex << 2) + (channelCfg >> 2));
    packet[3] = (char) (((channelCfg & 3) << 6) + (fullLength >> 11));
    packet[4] = (char) ((fullLength & 0x7FF) >> 3);
    packet[5] = (char) (((fullLength & 7) << 5) + 0x1F);
    packet[6] = (char) 0xFC;
    NSData *data = [NSData dataWithBytesNoCopy:packet length:adtsLength freeWhenDone:YES];
    
    return data;
}

// 音频采样率对应的 index。
- (NSInteger)sampleRateIndex:(NSInteger)frequencyInHz {
    NSInteger sampleRateIndex = 0;
    switch (frequencyInHz) {
        case 96000:
            sampleRateIndex = 0;
            break;
        case 88200:
            sampleRateIndex = 1;
            break;
        case 64000:
            sampleRateIndex = 2;
            break;
        case 48000:
            sampleRateIndex = 3;
            break;
        case 44100:
            sampleRateIndex = 4;
            break;
        case 32000:
            sampleRateIndex = 5;
            break;
        case 24000:
            sampleRateIndex = 6;
            break;
        case 22050:
            sampleRateIndex = 7;
            break;
        case 16000:
            sampleRateIndex = 8;
            break;
        case 12000:
            sampleRateIndex = 9;
            break;
        case 11025:
            sampleRateIndex = 10;
            break;
        case 8000:
            sampleRateIndex = 11;
            break;
        case 7350:
            sampleRateIndex = 12;
            break;
        default:
            sampleRateIndex = 15;
    }
    
    return sampleRateIndex;
}

@end
