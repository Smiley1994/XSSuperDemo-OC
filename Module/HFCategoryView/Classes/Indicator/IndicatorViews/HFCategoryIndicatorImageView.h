//
//  HFCategoryIndicatorImageView.h
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/17.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryIndicatorComponentView.h"

@interface HFCategoryIndicatorImageView : HFCategoryIndicatorComponentView

// 指示器图片
@property (nonatomic, strong, readonly) UIImageView *indicatorImageView;
// 图片是否开启滚动，默认值为 NO
@property (nonatomic, assign) BOOL indicatorImageViewRollEnabled;
// 图片的尺寸，默认值为 CGSizeMake(30, 20)
@property (nonatomic, assign) CGSize indicatorImageViewSize;

@end
