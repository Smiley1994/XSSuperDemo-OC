//
//  HFCategoryIndicatorTriangleView.m
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/17.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryIndicatorTriangleView.h"
#import "HFCategoryFactory.h"

@interface HFCategoryIndicatorTriangleView ()
@property (nonatomic, strong) CAShapeLayer *triangleLayer;
@end

@implementation HFCategoryIndicatorTriangleView

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
    self.indicatorWidth = 14;
    self.indicatorHeight = 10;

    _triangleLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.triangleLayer];
}

#pragma mark - HFCategoryIndicatorProtocol

- (void)hf_refreshState:(HFCategoryIndicatorParamsModel *)model {
    CGFloat x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - [self indicatorWidthValue:model.selectedCellFrame])/2;
    CGFloat y = self.superview.bounds.size.height - [self indicatorHeightValue:model.selectedCellFrame] - self.verticalMargin;
    if (self.componentPosition == HFCategoryComponentPosition_Top) {
        y = self.verticalMargin;
    }
    self.frame = CGRectMake(x, y, [self indicatorWidthValue:model.selectedCellFrame], [self indicatorHeightValue:model.selectedCellFrame]);

    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    self.triangleLayer.fillColor = self.indicatorColor.CGColor;
    self.triangleLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (self.componentPosition == HFCategoryComponentPosition_Bottom) {
        [path moveToPoint:CGPointMake(self.bounds.size.width/2, 0)];
        [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    } else {
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height)];
    }
    [path closePath];
    self.triangleLayer.path = path.CGPath;
    [CATransaction commit];
}

- (void)hf_contentScrollViewDidScroll:(HFCategoryIndicatorParamsModel *)model {
    CGRect rightCellFrame = model.rightCellFrame;
    CGRect leftCellFrame = model.leftCellFrame;
    CGFloat percent = model.percent;
    CGFloat targetWidth = [self indicatorWidthValue:model.leftCellFrame];
    CGFloat targetX = 0;

    if (percent == 0) {
        targetX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2.0;
    } else {
        CGFloat leftX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2;
        CGFloat rightX = rightCellFrame.origin.x + (rightCellFrame.size.width - targetWidth)/2;
        targetX = [HFCategoryFactory interpolationFrom:leftX to:rightX percent:percent];
    }

    //允许变动frame的情况：1、允许滚动；2、不允许滚动，但是已经通过手势滚动切换一页内容了；
    if (self.isScrollEnabled == YES || (self.isScrollEnabled == NO && percent == 0)) {
        CGRect frame = self.frame;
        frame.origin.x = targetX;
        self.frame = frame;
    }
}

- (void)hf_selectedCell:(HFCategoryIndicatorParamsModel *)model {
    CGRect toFrame = self.frame;
    toFrame.origin.x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - [self indicatorWidthValue:model.selectedCellFrame])/2;
    if (self.isScrollEnabled) {
        [UIView animateWithDuration:self.scrollAnimationDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.frame = toFrame;
        } completion:^(BOOL finished) {
        }];
    } else {
        self.frame = toFrame;
    }
}

@end
