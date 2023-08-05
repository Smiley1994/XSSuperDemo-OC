//
//  YSUError.h
//  YiShop
//
//  Created by 孙晓松 on 2016/11/14.
//  Copyright © 2016年 秦皇岛商之翼网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSUError : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *reason;

- (instancetype)initWithCode:(NSInteger)code;
- (instancetype)initWithCode:(NSInteger)code andReason:(NSString *)reason;
+ (instancetype)ok;
+ (instancetype)unknown;
+ (instancetype)errorWithCode:(NSInteger)code;
+ (instancetype)errorWithCode:(NSInteger)code andReason:(NSString *)reason;

@end
