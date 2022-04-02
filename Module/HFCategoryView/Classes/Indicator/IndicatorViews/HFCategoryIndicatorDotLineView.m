//
//  HFCategoryIndicatorDotLineView.m
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/22.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryIndicatorDotLineView.h"
#import "HFCategoryFactory.h"
#import "HFCategoryViewAnimator.h"

@interface HFCategoryIndicatorDotLineView ()
@property (nonatomic, strong) HFCategoryViewAnimator *animator;
@end

@implementation HFCategoryIndicatorDotLineView

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
    self.indicatorWidth = 10;
    self.indicatorHeight = 10;
    _lineWidth = 50;
}

#pragma mark - HFCategoryIndicatorProtocol

- (void)hf_refreshState:(HFCategoryIndicatorParamsModel *)model {
    CGFloat dotWidth = [self indicatorWidthValue:model.selectedCellFrame];
    CGFloat dotHeight = [self indicatorHeightValue:model.selectedCellFrame];
    self.backgroundColor = self.indicatorColor;
    self.layer.cornerRadius = [self indicatorHeightValue:model.selectedCellFrame]/2;

    CGFloat x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - dotWidth)/2;
    CGFloat y = self.superview.bounds.size.height - dotHeight - self.verticalMargin;
    if (self.componentPosition == HFCategoryComponentPosition_Top) {
        y = self.verticalMargin;
    }
    self.frame = CGRectMake(x, y, dotWidth, dotHeight);
}

- (void)hf_contentScrollViewDidScroll:(HFCategoryIndicatorParamsModel *)model {
    if (self.animator.isExecuting) {
        [self.animator invalid];
        self.animator = nil;
    }
    CGFloat dotWidth = [self indicatorWidthValue:model.selectedCellFrame];
    CGRect rightCellFrame = model.rightCellFrame;
    CGRect leftCellFrame = model.leftCellFrame;
    CGFloat percent = model.percent;
    CGFloat targetX = 0;
    CGFloat targetWidth = dotWidth;
    CGFloat leftWidth = dotWidth;
    CGFloat rightWidth = dotWidth;
    CGFloat leftX = leftCellFrame.origin.x + (leftCellFrame.size.width - leftWidth)/2;
    CGFloat rightX = rightCellFrame.origin.x + (rightCellFrame.size.width - rightWidth)/2;
    CGFloat centerX = leftX + (rightX - leftX - self.lineWidth)/2;

    //前50%，移动x，增加宽度；后50%，移动x并减小width
    if (percent <= 0.5) {
        targetX = [HFCategoryFactory interpolationFrom:leftX to:centerX percent:percent*2];
        targetWidth = [HFCategoryFactory interpolationFrom:dotWidth to:self.lineWidth percent:percent*2];
    }else {
        targetX = [HFCategoryFactory interpolationFrom:centerX to:rightX percent:(percent - 0.5)*2];
        targetWidth = [HFCategoryFactory interpolationFrom:self.lineWidth to:dotWidth percent:(percent - 0.5)*2];
    }

    //允许变动frame的情况：1、允许滚动；2、不允许滚动，但是已经通过手势滚动切换一页内容了；
    if (self.isScrollEnabled == YES || (self.isScrollEnabled == NO && percent == 0)) {
        CGRect frame = self.frame;
        frame.origin.x = targetX;
        frame.size.width = targetWidth;
        self.frame = frame;
    }
}

- (void)hf_selectedCell:(HFCategoryIndicatorParamsModel *)model {
    CGFloat dotWidth = [self indicatorWidthValue:model.selectedCellFrame];
    CGFloat x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - dotWidth)/2;
    CGRect targetIndicatorFrame = self.frame;
    targetIndicatorFrame.origin.x = x;
    if (self.isScrollEnabled) {
        if (self.scrollStyle == HFCategoryIndicatorScrollStyleSameAsUserScroll && (model.selectedType == HFCategoryCellSelectedTypeClick | model.selectedType == HFCategoryCellSelectedTypeCode)) {
            if (self.animator.isExecuting) {
                [self.animator invalid];
                self.animator = nil;
            }
            CGFloat leftX = 0;
            CGFloat rightX = 0;
            BOOL isNeedReversePercent = NO;
            if (self.frame.origin.x > model.selectedCellFrame.origin.x) {
                leftX = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - dotWidth)/2;;
                rightX = self.frame.origin.x;
                isNeedReversePercent = YES;
            }else {
                leftX = self.frame.origin.x;
                rightX = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - dotWidth)/2;
            }
            CGFloat centerX = leftX + (rightX - leftX - self.lineWidth)/2;
            __weak typeof(self) weakSelf = self;
            self.animator = [[HFCategoryViewAnimator alloc] init];
            self.animator.progressCallback = ^(CGFloat percent) {
                if (isNeedReversePercent) {
                    percent = 1 - percent;
                }
                CGFloat targetX = 0;
                CGFloat targetWidth = 0;
                if (percent <= 0.5) {
                    targetX = [HFCategoryFactory interpolationFrom:leftX to:centerX percent:percent*2];
                    targetWidth = [HFCategoryFactory interpolationFrom:dotWidth to:self.lineWidth percent:percent*2];
                }else {
                    targetX = [HFCategoryFactory interpolationFrom:centerX to:rightX percent:(percent - 0.5)*2];
                    targetWidth = [HFCategoryFactory interpolationFrom:self.lineWidth to:dotWidth percent:(percent - 0.5)*2];
                }
                CGRect toFrame = weakSelf.frame;
                toFrame.origin.x = targetX;
                toFrame.size.width = targetWidth;
                weakSelf.frame = toFrame;
            };
            [self.animator start];
        }else if (self.scrollStyle == HFCategoryIndicatorScrollStyleSimple) {
            [UIView animateWithDuration:self.scrollAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.frame = targetIndicatorFrame;
            } completion: nil];
        }
    }else {
        self.frame = targetIndicatorFrame;
    }
}

@end
