//
//  FJReplayKit.m
//  TTReadBook
//
//  Created by fengjie on 2017/9/13.
//  Copyright © 2017年 . All rights reserved.
//

#import "FJReplayKit.h"

//弱引用
#define kWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;


@interface FJReplayKit ()<RPPreviewViewControllerDelegate>

@end

@implementation FJReplayKit

+(instancetype)sharedReplay{
    static FJReplayKit *replay=nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        replay=[[FJReplayKit alloc] init];
    });
    return replay;
}
-(void)startAction{
    
    [[FJReplayKit sharedReplay] startRecord];
}
-(void)endAction{
    
    [[FJReplayKit sharedReplay] stopRecordAndShowVideoPreviewController:YES];
}
//是否正在录制
-(BOOL)isRecording{
    return [RPScreenRecorder sharedRecorder].recording;
}
#pragma mark - 开始/结束录制
//开始录制
-(void)startRecord{
    if ([RPScreenRecorder sharedRecorder].recording==YES) {
        NSLog(@"FJReplayKit:已经开始录制");
        return;
    }
    if ([self systemVersionOK]) {
        if ([[RPScreenRecorder sharedRecorder] isAvailable]) {
            NSLog(@"FJReplayKit:录制开始初始化");
            
            if ([UIDevice currentDevice].systemVersion.floatValue < 10.0f) {
                [self ios9_ios10];
            }else{
                [self ios_10];
            }
            
        }else {
            NSLog(@"FJReplayKit:环境不支持ReplayKit录制");
            if ([_delegate respondsToSelector:@selector(replayRecordFinishWithVC:errorInfo:)]) {
                [_delegate replayRecordFinishWithVC:nil errorInfo:@"FJReplayKit:环境不支持ReplayKit录制"];
            }
        }
    }
    else{
        NSLog(@"FJReplayKit:系统版本需要是iOS9.0及以上才支持ReplayKit录制");
        if ([_delegate respondsToSelector:@selector(replayRecordFinishWithVC:errorInfo:)]) {
            [_delegate replayRecordFinishWithVC:nil errorInfo:@"FJReplayKit:系统版本需要是iOS9.0及以上才支持ReplayKit录制"];
        }
    }
}
-(void)ios_10{
     kWeakSelf(weakSelf);
    if (@available(iOS 10.0, *)) {
        [[RPScreenRecorder sharedRecorder] startRecordingWithHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"FJReplayKit:开始录制error %@",error);
                if ([weakSelf.delegate respondsToSelector:@selector(replayRecordFinishWithVC:errorInfo:)]) {
                    [weakSelf.delegate replayRecordFinishWithVC:nil errorInfo:[NSString stringWithFormat:@"FJReplayKit:开始录制error %@",error]];
                }
            }else{
                NSLog(@"FJReplayKit:开始录制");
                if ([weakSelf.delegate respondsToSelector:@selector(replayRecordStart)]) {
                    [weakSelf.delegate replayRecordStart];
                }
            }
        }];
    } else {
        // Fallback on earlier versions
    }
}
-(void)ios9_ios10 API_DEPRECATED("Use microphoneEnabaled property", ios(9.0, 10.0)){
    
    kWeakSelf(weakSelf);
    
    [[RPScreenRecorder sharedRecorder] startRecordingWithMicrophoneEnabled:YES handler:^(NSError *error){
        if (error) {
            NSLog(@"FJReplayKit:开始录制error %@",error);
            
            if ([weakSelf.delegate respondsToSelector:@selector(replayRecordFinishWithVC:errorInfo:)]) {
                [weakSelf.delegate replayRecordFinishWithVC:nil errorInfo:[NSString stringWithFormat:@"FJReplayKit:开始录制error %@",error]];
            }
        }else{
            NSLog(@"FJReplayKit:开始录制");
            if ([weakSelf.delegate respondsToSelector:@selector(replayRecordStart)]) {
                [weakSelf.delegate replayRecordStart];
            }
        }
    }];

}
//结束录制
-(void)stopRecordAndShowVideoPreviewController:(BOOL)isShow{
    NSLog(@"FJReplayKit:正在结束录制");
    kWeakSelf(weakSelf);

    [[RPScreenRecorder sharedRecorder] stopRecordingWithHandler:^(RPPreviewViewController *previewViewController, NSError *  error){
        if (error) {
            NSLog(@"FJReplayKit:结束录制error %@", error);
            if ([weakSelf.delegate respondsToSelector:@selector(replayRecordFinishWithVC:errorInfo:)]) {
                [weakSelf.delegate replayRecordFinishWithVC:nil errorInfo:[NSString stringWithFormat:@"FJReplayKit:结束录制error %@",error]];
            }
        }
        else {
            NSLog(@"FJReplayKit:录制完成");
            if ([weakSelf.delegate respondsToSelector:@selector(replayRecordFinishWithVC:errorInfo:)]) {
                [weakSelf.delegate replayRecordFinishWithVC:previewViewController errorInfo:@""];
            }
            if (isShow) {
                [self showVideoPreviewController:previewViewController animation:YES];
            }
        }
    }];
}
#pragma mark - 显示/关闭视频预览页
//显示视频预览页面
-(void)showVideoPreviewController:(RPPreviewViewController *)previewController animation:(BOOL)animation {
    previewController.previewControllerDelegate=self;
    
    __weak UIViewController *rootVC=[self getRootVC];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect rect = [UIScreen mainScreen].bounds;
        
        if (animation) {
            rect.origin.x+=rect.size.width;
            previewController.view.frame=rect;
            rect.origin.x-=rect.size.width;
            [UIView animateWithDuration:0.3 animations:^(){
                previewController.view.frame=rect;
            }];
        }
        else{
            previewController.view.frame=rect;
        }
        
        [rootVC.view addSubview:previewController.view];
        [rootVC addChildViewController:previewController];
    });
    
}
//关闭视频预览页面
-(void)hideVideoPreviewController:(RPPreviewViewController *)previewController animation:(BOOL)animation {
    previewController.previewControllerDelegate=nil;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect rect = previewController.view.frame;
        
        if (animation) {
            rect.origin.x+=rect.size.width;
            [UIView animateWithDuration:0.3 animations:^(){
                previewController.view.frame=rect;
            }completion:^(BOOL finished){
                [previewController.view removeFromSuperview];
                [previewController removeFromParentViewController];
            }];
            
        }
        else{
            [previewController.view removeFromSuperview];
            [previewController removeFromParentViewController];
        }
    });
}
#pragma mark - 视频预览页回调
//关闭的回调
- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController {
    [self hideVideoPreviewController:previewController animation:YES];
}
//选择了某些功能的回调（如分享和保存）
- (void)previewController:(RPPreviewViewController *)previewController didFinishWithActivityTypes:(NSSet <NSString *> *)activityTypes {
    if ([activityTypes containsObject:@"com.apple.UIKit.activity.SaveToCameraRoll"]) {
        NSLog(@"FJReplayKit:保存到相册成功");
        if ([_delegate respondsToSelector:@selector(saveSuccess)]) {
            [_delegate saveSuccess];
        }
    }
    if ([activityTypes containsObject:@"com.apple.UIKit.activity.CopyToPasteboard"]) {
        NSLog(@"FJReplayKit:复制成功");
    }
}
#pragma mark - 其他方法
//判断对应系统版本是否支持ReplayKit
-(BOOL)systemVersionOK{
    if ([[UIDevice currentDevice].systemVersion floatValue]<9.0) {
        return NO;
    } else {
        return YES;
    }
}
//获取rootVC
-(UIViewController *)getRootVC{
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

@end

