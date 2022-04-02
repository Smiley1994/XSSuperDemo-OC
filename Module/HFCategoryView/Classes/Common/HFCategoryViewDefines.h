//
//  HFCategoryViewDefines.h
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/17.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static const CGFloat HFCategoryViewAutomaticDimension = -1;

typedef void(^HFCategoryCellSelectedAnimationBlock)(CGFloat percent);

// 指示器的位置
typedef NS_ENUM(NSUInteger, HFCategoryComponentPosition) {
    HFCategoryComponentPosition_Bottom,
    HFCategoryComponentPosition_Top
};

// cell 被选中的类型
typedef NS_ENUM(NSUInteger, HFCategoryCellSelectedType) {
    HFCategoryCellSelectedTypeUnknown, // 未知，不是选中（cellForRow方法里面、两个cell过渡时）
    HFCategoryCellSelectedTypeClick,   // 点击选中
    HFCategoryCellSelectedTypeCode,    // 调用方法 selectItemAtIndex: 选中
    HFCategoryCellSelectedTypeScroll   // 通过滚动到某个 cell 选中
};

// cell 标题锚点位置
typedef NS_ENUM(NSUInteger, HFCategoryTitleLabelAnchorPointStyle) {
    HFCategoryTitleLabelAnchorPointStyleCenter,
    HFCategoryTitleLabelAnchorPointStyleTop,
    HFCategoryTitleLabelAnchorPointStyleBottom
};

// 指示器滚动样式
typedef NS_ENUM(NSUInteger, HFCategoryIndicatorScrollStyle) {
    HFCategoryIndicatorScrollStyleSimple,           // 简单滚动，即从当前位置过渡到目标位置
    HFCategoryIndicatorScrollStyleSameAsUserScroll  // 和用户左右滚动列表时的效果一样
};

#define HFCategoryViewDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
