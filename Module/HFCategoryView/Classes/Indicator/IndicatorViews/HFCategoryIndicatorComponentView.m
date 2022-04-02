//
//  HFCategoryIndicatorComponentView.m
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/17.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryIndicatorComponentView.h"

@implementation HFCategoryIndicatorComponentView

#pragma mark - Initialize

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureDefaultValue];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self configureDefaultValue];
    }
    return self;
}

- (void)configureDefaultValue {
    _componentPosition = HFCategoryComponentPosition_Bottom;
    _scrollEnabled = YES;
    _verticalMargin = 0;
    _scrollAnimationDuration = 0.25;
    _indicatorWidth = HFCategoryViewAutomaticDimension;
    _indicatorWidthIncrement = 0;
    _indicatorHeight = 3;
    _indicatorCornerRadius = HFCategoryViewAutomaticDimension;
    _indicatorColor = [UIColor redColor];
    _scrollStyle = HFCategoryIndicatorScrollStyleSimple;
}

#pragma mark - Public

- (CGFloat)indicatorWidthValue:(CGRect)cellFrame {
    if (self.indicatorWidth == HFCategoryViewAutomaticDimension) {
        return cellFrame.size.width + self.indicatorWidthIncrement;
    }
    return self.indicatorWidth + self.indicatorWidthIncrement;
}

- (CGFloat)indicatorHeightValue:(CGRect)cellFrame {
    if (self.indicatorHeight == HFCategoryViewAutomaticDimension) {
        return cellFrame.size.height;
    }
    return self.indicatorHeight;
}

- (CGFloat)indicatorCornerRadiusValue:(CGRect)cellFrame {
    if (self.indicatorCornerRadius == HFCategoryViewAutomaticDimension) {
        return [self indicatorHeightValue:cellFrame]/2;
    }
    return self.indicatorCornerRadius;
}

#pragma mark - HFCategoryIndicatorProtocol

- (void)hf_refreshState:(HFCategoryIndicatorParamsModel *)model {

}

- (void)hf_contentScrollViewDidScroll:(HFCategoryIndicatorParamsModel *)model {

}

- (void)hf_selectedCell:(HFCategoryIndicatorParamsModel *)model {
    
}

@end
