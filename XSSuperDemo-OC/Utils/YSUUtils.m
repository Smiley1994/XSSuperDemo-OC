//
//  YSUUtils.m
//  YiShop
//
//  Created by 孙晓松 on 2016/11/11.
//  Copyright © 2016年 秦皇岛商之翼网络科技有限公司. All rights reserved.
//

#import "YSUUtils.h"
#import "NSString+Trim.h"
#import "XSUIMacro.h"
#import <Foundation/Foundation.h>

id isNil(id obj) {
    if (!obj) return [NSNull null];
    else            return obj;
}

@implementation YSUUtils

+ (BOOL)isThreeSevenInchDevice {
    return (SCREEN_WIDTH == 320 && SCREEN_HEIGHT == 480) || (SCREEN_WIDTH == 480 && SCREEN_HEIGHT == 320);
}

+ (BOOL)isFourZeroInchDevice {
    return (SCREEN_WIDTH == 320 && SCREEN_HEIGHT == 568) || (SCREEN_WIDTH == 568 && SCREEN_HEIGHT == 320);
}

+ (BOOL)isFourSevenInchDevice {
    return (SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 667) || (SCREEN_WIDTH == 667 && SCREEN_HEIGHT == 375);
}

+ (BOOL)isFiveFiveInchDevice {
    return (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 736) || (SCREEN_WIDTH == 736 && SCREEN_HEIGHT == 414);
}

+ (BOOL)isFiveEightInchDevice {
    return (SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812) || (SCREEN_WIDTH == 812 && SCREEN_HEIGHT == 375);
}

+ (BOOL)isNullString:(NSString*)string {
    return !string || !string.length || string.length == 0 || [string trim].length == 0;
}

+ (UIColor*)colorOfHexString:(NSString*)hexString {
    NSScanner* scanner = [NSScanner scannerWithString:hexString];
    if ([hexString hasPrefix:@"#"]) {
        [scanner setScanLocation:1];
    }
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    
    int r = (hexNum >> 16) & 0xFF;
    int g = (hexNum >> 8) & 0xFF;
    int b = (hexNum)&0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

+ (BOOL)writeToFileWithKey:(NSString*)key AndValue:(NSString*)value {
    return [YSUUtils writeToFile:@"default" withKey:key andValue:value];
}

+ (BOOL)writeToFile:(NSString*)fileName withKey:(NSString*)key andValue:(NSString*)value{
    NSArray* paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0) {
        NSString* path = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
        NSDictionary* dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        if (dictionary == nil) {
            dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:value, key, nil];
        } else {
            [dictionary setValue:value forKey:key];
        }
        return [dictionary writeToFile:path atomically:YES];
    } else {
        return NO;
    }
}

+ (id)readFileWithKey:(NSString *)key {
    return [YSUUtils readFile:@"default" withKey:key];
}

+ (id)readFile:(NSString *)fileName withKey:(NSString *)key {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0) {
        NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        if (dictionary == nil) {
            return nil;
        } else {
            return [dictionary objectForKey:key];
        }
    } else {
        return nil;
    }
}

+ (UIImage *)shrinkImage:(UIImage *)image maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight {
    if (image.size.width < maxWidth && image.size.height < maxHeight) {
        return image;
    }
    float scaleFactor = MAX (image.size.width / maxWidth, image.size.height / maxHeight);
    CGSize newSize = CGSizeMake (image.size.width * scaleFactor, image.size.height * scaleFactor);
    UIGraphicsBeginImageContext (newSize);
    [image drawInRect:CGRectMake (0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext ();
    return newImage;
}

+ (BOOL)openBrowser:(NSString *)urlString {
    NSURL* url = [NSURL URLWithString:urlString];
    if (!url) {
        return NO;
    }
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)removeExtraSlashOfUrl:(NSString *)url {
    if (!url || url.length == 0) {
        return url;
    }
    NSString *pattern = @"(?<!(http:|https:))/+";
    NSRegularExpression *expression = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    return [expression stringByReplacingMatchesInString:url options:0 range:NSMakeRange(0, url.length) withTemplate:@"/"];
}

+ (NSString *)getDomain:(NSString *)urlString {
    NSURL *url =[NSURL URLWithString:urlString];
    if(!url){
        return nil;
    }
    
    NSString *host = url.host;
    NSArray *array = [host componentsSeparatedByString:@"."];
    if (array.count < 2) {
        return nil;
    }
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
    [mutableArray removeObjectAtIndex:0];
    NSString *domain = [mutableArray componentsJoinedByString:@"."];
    return domain;
}

@end
