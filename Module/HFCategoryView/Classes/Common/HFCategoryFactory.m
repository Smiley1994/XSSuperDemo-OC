//
//  HFCategoryFactory.m
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/17.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryFactory.h"
#import "UIColor+HFAdd.h"

@implementation HFCategoryFactory

+ (CGFloat)interpolationFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent
{
    percent = MAX(0, MIN(1, percent));
    return from + (to - from)*percent;
}

+ (UIColor *)interpolationColorFrom:(UIColor *)fromColor to:(UIColor *)toColor percent:(CGFloat)percent
{
    CGFloat red = [self interpolationFrom:fromColor.hf_red to:toColor.hf_red percent:percent];
    CGFloat green = [self interpolationFrom:fromColor.hf_green to:toColor.hf_green percent:percent];
    CGFloat blue = [self interpolationFrom:fromColor.hf_blue to:toColor.hf_blue percent:percent];
    CGFloat alpha = [self interpolationFrom:fromColor.hf_alpha to:toColor.hf_alpha percent:percent];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
