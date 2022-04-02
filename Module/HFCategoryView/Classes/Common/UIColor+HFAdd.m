//
//  UIColor+HFAdd.m
//  UI系列测试
//
//  Created by Macrolor on 2018/3/21.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "UIColor+HFAdd.h"

@implementation UIColor (HFAdd)

- (CGFloat)hf_red {
    CGFloat r = 0, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r;
}

- (CGFloat)hf_green {
    CGFloat r, g = 0, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g;
}

- (CGFloat)hf_blue {
    CGFloat r, g, b = 0, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b;
}

- (CGFloat)hf_alpha {
    return CGColorGetAlpha(self.CGColor);
}

@end
