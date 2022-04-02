//
//  HFCategoryIndicatorLineView.h
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/17.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryIndicatorComponentView.h"

typedef NS_ENUM(NSUInteger, HFCategoryIndicatorLineStyle) {
    HFCategoryIndicatorLineStyle_Normal         = 0,
    HFCategoryIndicatorLineStyle_Lengthen       = 1,
    HFCategoryIndicatorLineStyle_LengthenOffset = 2,
};

@interface HFCategoryIndicatorLineView : HFCategoryIndicatorComponentView

@property (nonatomic, assign) HFCategoryIndicatorLineStyle lineStyle;

/**
 line 滚动时沿 x 轴方向上的偏移量，默认值为 10。
 
 lineStyle 为 HFCategoryIndicatorLineStyle_LengthenOffset 有用。
 */
@property (nonatomic, assign) CGFloat lineScrollOffsetX;

@end
