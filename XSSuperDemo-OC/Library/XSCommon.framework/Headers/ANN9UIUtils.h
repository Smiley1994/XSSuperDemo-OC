//
//  ANN9UIUtils.h
//  BabyLearnEnglish
//
//  Created by 晓松 on 2018/11/26.
//  Copyright © 2018 ann9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ANN9UIUtils : NSObject

+ (BOOL)isX;

+ (BOOL)isIPad;

+ (NSString *)iphoneType;

+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end

NS_ASSUME_NONNULL_END
