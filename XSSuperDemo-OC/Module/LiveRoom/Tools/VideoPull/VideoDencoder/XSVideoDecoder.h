//
//  XSVideoDencoder.h
//  XSSuperDemo-OC
//
//  Created by GoodMorning on 2023/8/12.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VideoToolbox/VideoToolbox.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XSVideoDecoderDelegate <NSObject>

/// H264解码数据回调
@optional
- (void)videoH264DecodeOutputData:(CVImageBufferRef)imageBuffer;

/// H265解码数据回调
@optional
- (void)videoH265DecodeOutputData:(CVImageBufferRef)imageBuffer;

@end

@interface XSVideoDecoder : NSObject

/// 代理
@property (weak, nonatomic) id<XSVideoDecoderDelegate> delegate;

/// 解码NALU数据 H264
-(void)decodeH264NaluData:(NSData *)naluData;

/// 解码NALU数据 H265
-(void)decodeH265NaluData:(NSData *)naluData;

@end

NS_ASSUME_NONNULL_END
