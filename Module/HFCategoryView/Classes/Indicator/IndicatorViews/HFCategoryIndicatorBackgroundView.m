//
//  HFCategoryIndicatorBackgroundView.m
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/17.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryIndicatorBackgroundView.h"
#import "HFCategoryFactory.h"

@implementation HFCategoryIndicatorBackgroundView

#pragma mark - Initialize

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureDefaulteValue];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self configureDefaulteValue];
    }
    return self;
}

- (void)configureDefaulteValue {
    self.indicatorWidth = HFCategoryViewAutomaticDimension;
    self.indicatorHeight = HFCategoryViewAutomaticDimension;
    self.indicatorCornerRadius = HFCategoryViewAutomaticDimension;
    self.indicatorColor = [UIColor lightGrayColor];
    self.indicatorWidthIncrement = 10;
}

#pragma mark - HFCategoryIndicatorProtocol

- (void)hf_refreshState:(HFCategoryIndicatorParamsModel *)model {
    self.layer.cornerRadius = [self indicatorCornerRadiusValue:model.selectedCellFrame];
    self.backgroundColor = self.indicatorColor;

    CGFloat width = [self indicatorWidthValue:model.selectedCellFrame];
    CGFloat height = [self indicatorHeightValue:model.selectedCellFrame];
    CGFloat x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - width)/2;
    CGFloat y = (model.selectedCellFrame.size.height - height)/2 - self.verticalMargin;
    self.frame = CGRectMake(x, y, width, height);
}

- (void)hf_contentScrollViewDidScroll:(HFCategoryIndicatorParamsModel *)model {
    CGRect rightCellFrame = model.rightCellFrame;
    CGRect leftCellFrame = model.leftCellFrame;
    CGFloat percent = model.percent;
    CGFloat targetX = 0;
    CGFloat targetWidth = [self indicatorWidthValue:leftCellFrame];

    if (percent == 0) {
        targetX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2.0;
    }else {
        CGFloat leftWidth = targetWidth;
        CGFloat rightWidth = [self indicatorWidthValue:rightCellFrame];

        CGFloat leftX = leftCellFrame.origin.x + (leftCellFrame.size.width - leftWidth)/2;
        CGFloat rightX = rightCellFrame.origin.x + (rightCellFrame.size.width - rightWidth)/2;

        targetX = [HFCategoryFactory interpolationFrom:leftX to:rightX percent:percent];

        if (self.indicatorWidth == HFCategoryViewAutomaticDimension) {
            targetWidth = [HFCategoryFactory interpolationFrom:leftWidth to:rightWidth percent:percent];
        }
    }

    //允许变动frame的情况：1、允许滚动；2、不允许滚动，但是已经通过手势滚动切换一页内容了；
    if (self.isScrollEnabled == YES || (self.isScrollEnabled == NO && percent == 0)) {
        CGRect toFrame = self.frame;
        toFrame.origin.x = targetX;
        toFrame.size.width = targetWidth;
        self.frame = toFrame;
    }
}

- (void)hf_selectedCell:(HFCategoryIndicatorParamsModel *)model {
    CGFloat width = [self indicatorWidthValue:model.selectedCellFrame];
    CGRect toFrame = self.frame;
    toFrame.origin.x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - width)/2;
    toFrame.size.width = width;

    if (self.isScrollEnabled) {
        [UIView animateWithDuration:self.scrollAnimationDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.frame = toFrame;
        } completion:^(BOOL finished) {
        }];
    }else {
        self.frame = toFrame;
    }
}

@end
