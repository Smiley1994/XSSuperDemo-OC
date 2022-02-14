//
//  XSUserViewController.m
//  XSSuperDemo-OC
//
//  Created by Good_Morning_ on 2018/7/2.
//  Copyright © 2018年 GoodMorning. All rights reserved.
//

#import "XSUserViewController.h"
#import "XSPlayingLineView.h"

@interface XSUserViewController ()

@end

@implementation XSUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    void (^block)(void) = ^() {
        int i = 1;
        i ++;
    };
    
    block();
    
    
    
    XSPlayingLineView *lineView = [[XSPlayingLineView alloc] initWithFrame:CGRectMake(50, 100, 9, 9) lineWidth:1.5 lineColor:[UIColor redColor]];
    [self.view addSubview:lineView];
    
//    CAReplicatorLayer *replicatorLayer = [[CAReplicatorLayer alloc] init];
//    replicatorLayer.frame = CGRectMake(0, 100, 375, 200);
//    replicatorLayer.instanceCount = 16;
//    replicatorLayer.instanceTransform  = CATransform3DMakeTranslation(20, 0, 0);
//    replicatorLayer.instanceDelay = 0.2;
//    replicatorLayer.masksToBounds = YES;
//    replicatorLayer.backgroundColor = [UIColor blackColor].CGColor;
//
//    CALayer *layer = [CALayer layer];
//    layer.frame = CGRectMake(14, 200, 10, 100);
//    layer.backgroundColor = [UIColor redColor].CGColor;
//    [replicatorLayer addSublayer:layer];
//    [self.view.layer addSublayer:replicatorLayer];
//
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"position.y";
//    animation.duration = 0.5;
//    animation.fromValue = @200;
//    animation.toValue = @150;
//    animation.autoreverses = YES;
//    animation.repeatCount = MAXFLOAT;
//    [layer addAnimation:animation forKey:nil];
    
}
//1.通过手机越狱后增加的越狱文件判断
//static const char* jailbreak_apps[] = {
//    "/Applications/Cydia.app",
//    "/Applications/limera1n.app",
//    "/Applications/greenpois0n.app",
//    "/Applications/blackra1n.app",
//    "/Applications/blacksn0w.app",
//    "/Applications/redsn0w.app",
//    "/Applications/Absinthe.app",
//    "/Library/MobileSubstrate/MobileSubstrate.dylib",
//    "/bin/bash",
//    "/usr/sbin/sshd",
//    "/etc/apt",
//    "/private/var/lib/apt/",
//    NULL,
//};

//- (BOOL)isJailBreak {
//    for (int i = 0; i < jailbreak_tool_paths.count; i++) {
//        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_apps[i]]]) {
//            NSLog(@"The device is jail broken!");
//            return YES;
//        }
//    }
//    NSLog(@"The device is NOT jail broken!");
//    return NO;
//}

//2.根据是否能打开cydia判断
//-(BOOL)isJailBreak {
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
//        NSLog(@"The device is jail broken!");
//        return YES;
//    }
//    NSLog(@"The device is NOT jail broken!");
//    return NO;
//}

//3.根据是否能获取所有应用的名称判断,没有越狱的设备是没有读取所有应用名称的权限的。
//- (BOOL)isJailBreak {
//    if ([[NSFileManager defaultManager] fileExistsAtPath:@"User/Applications/"]) {
//        NSLog(@"The device is jail broken!");
//        NSArray *appList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"User/Applications/" error:nil];
//        NSLog(@"appList = %@", appList);
//        return YES;
//    }
//    NSLog(@"The device is NOT jail broken!");
//    return NO;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
