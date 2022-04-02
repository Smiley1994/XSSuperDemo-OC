//
//  HFCategoryIndicatorCellModel.h
//  DQGuess
//
//  Created by Macrolor on 2018/7/25.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFCategoryBaseCellModel.h"

@interface HFCategoryIndicatorCellModel : HFCategoryBaseCellModel

@property (nonatomic, assign, getter=isSepratorLineShowEnabled) BOOL sepratorLineShowEnabled;

@property (nonatomic, strong) UIColor *separatorLineColor;

@property (nonatomic, assign) CGSize separatorLineSize;

@property (nonatomic, assign) CGRect backgroundViewMaskFrame; // 底部指示器的 frame 转换到 cell 的 frame

@property (nonatomic, assign, getter=isCellBackgroundColorGradientEnabled) BOOL cellBackgroundColorGradientEnabled;

@property (nonatomic, strong) UIColor *cellBackgroundSelectedColor;

@property (nonatomic, strong) UIColor *cellBackgroundUnselectedColor;

@end
