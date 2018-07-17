//
//  NSString+Trim.m
//  YiShop
//
//  Created by 孙晓松 on 2016/11/18.
//  Copyright © 2016年 秦皇岛商之翼网络科技有限公司. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString(Trim)

- (instancetype)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
