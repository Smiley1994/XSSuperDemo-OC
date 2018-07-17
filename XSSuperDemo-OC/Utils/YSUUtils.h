//
//  YSUUtils.h
//  YiShop
//
//  Created by 孙晓松 on 2016/11/11.
//  Copyright © 2016年 秦皇岛商之翼网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

id isNil(id obj);

@interface YSUUtils : NSObject

+ (BOOL)isThreeSevenInchDevice;

+ (BOOL)isFourZeroInchDevice;

+ (BOOL)isFourSevenInchDevice;

+ (BOOL)isFiveFiveInchDevice;

//  iPhone X
+ (BOOL)isFiveEightInchDevice;

+ (BOOL)isNullString:(NSString *)string;

+ (UIColor *)colorOfHexString:(NSString *)hexString;

+ (BOOL)writeToFileWithKey:(NSString *)key AndValue:(id)value;

+ (BOOL)writeToFile:(NSString *)fileName withKey:(NSString *)key andValue:(id)value;

+ (id)readFileWithKey:(NSString *)key;

+ (id)readFile:(NSString *)fileName withKey:(NSString *)key;

+ (UIImage *)shrinkImage:(UIImage *)image maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;

+ (BOOL)openBrowser:(NSString *)urlString;

+ (NSString *)removeExtraSlashOfUrl:(NSString *)url;

+ (NSString *)getDomain:(NSString *)url;

@end
