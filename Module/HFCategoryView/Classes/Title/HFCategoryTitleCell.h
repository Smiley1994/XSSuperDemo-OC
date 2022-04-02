//
//  HFCategoryTitleCell.h
//  UI系列测试
//
//  Created by Macrolor on 2018/3/15.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryIndicatorCell.h"
#import "HFCategoryViewDefines.h"
@class HFCategoryTitleCellModel;

@interface HFCategoryTitleCell : HFCategoryIndicatorCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *maskTitleLabel;
@property (nonatomic, strong) NSLayoutConstraint *titleLabelCenterX;
@property (nonatomic, strong) NSLayoutConstraint *titleLabelCenterY;
@property (nonatomic, strong) NSLayoutConstraint *maskTitleLabelCenterX;

- (HFCategoryCellSelectedAnimationBlock)preferredTitleZoomAnimationBlock:(HFCategoryTitleCellModel *)cellModel baseScale:(CGFloat)baseScale;

- (HFCategoryCellSelectedAnimationBlock)preferredTitleStrokeWidthAnimationBlock:(HFCategoryTitleCellModel *)cellModel attributedString:(NSMutableAttributedString *)attributedString;

- (HFCategoryCellSelectedAnimationBlock)preferredTitleColorAnimationBlock:(HFCategoryTitleCellModel *)cellModel;

@end
