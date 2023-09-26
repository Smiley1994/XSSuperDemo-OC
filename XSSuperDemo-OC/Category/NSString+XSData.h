//
//  NSString+XSData.h
//  XSSuperDemo-OC
//
//  Created by mt230824 on 2023/9/20.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XSData)

/// 获取文件的MD5值
- (NSString *)fileMD5WithPath:(NSString* )path;

@end

NS_ASSUME_NONNULL_END
