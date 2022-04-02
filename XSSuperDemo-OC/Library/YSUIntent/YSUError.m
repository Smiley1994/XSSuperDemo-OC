//
//  YSUError.m
//  YiShop
//
//  Created by 孙晓松 on 2016/11/14.
//  Copyright © 2016年 秦皇岛商之翼网络科技有限公司. All rights reserved.
//

#import "YSUError.h"
#import "YSUErrorCode.h"

@implementation YSUError
- (instancetype)initWithCode:(NSInteger)code{
    self =[super init];
    if(self){
        self.code = code;
        self.reason = nil;
    }
    return self;
}

+ (instancetype)ok {
    return [[YSUError alloc]initWithCode:YSU_ERROR_OK];
}

+ (instancetype)unknown {
    return [[YSUError alloc]initWithCode:YSU_ERROR_UNKNOWN_ERROR andReason:@"未知错误"];
}

+ (instancetype)errorWithCode:(NSInteger)code {
    return [[YSUError alloc]initWithCode:code];
}

+ (instancetype)errorWithCode:(NSInteger)code andReason:(NSString *)reason {
    return [[YSUError alloc] initWithCode:code andReason:reason];
}

- (instancetype)initWithCode:(NSInteger)code andReason:(NSString *)reason {
    self =[super init];
    if(self){
        self.code = code;
        self.reason = reason;
    }
    return self;
}

@end
