//
//  XSUserViewController.m
//  XSSuperDemo-OC
//
//  Created by Good_Morning_ on 2018/7/2.
//  Copyright © 2018年 GoodMorning. All rights reserved.
//

#import "XSUserViewController.h"

@interface XSUserViewController ()

@end

@implementation XSUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
