//
//  HFCategoryIndicatorRainbowLineView.m
//  HFCategoryView
//
//  Created by Macrolor on 2018/12/13.
//  Copyright © 2018 Macrolor. All rights reserved.
//

#import "HFCategoryIndicatorRainbowLineView.h"
#import "HFCategoryFactory.h"

@implementation HFCategoryIndicatorRainbowLineView

- (void)hf_refreshState:(HFCategoryIndicatorParamsModel *)model {
    [super hf_refreshState:model];

    UIColor *color = self.indicatorColors[model.selectedIndex];
    self.backgroundColor = color;
}

- (void)hf_contentScrollViewDidScroll:(HFCategoryIndicatorParamsModel *)model {
    [super hf_contentScrollViewDidScroll:model];

    UIColor *leftColor = self.indicatorColors[model.leftIndex];
    UIColor *rightColor = self.indicatorColors[model.rightIndex];
    UIColor *color = [HFCategoryFactory interpolationColorFrom:leftColor to:rightColor percent:model.percent];
    self.backgroundColor = color;
}

- (void)hf_selectedCell:(HFCategoryIndicatorParamsModel *)model {
    [super hf_selectedCell:model];

    UIColor *color = self.indicatorColors[model.selectedIndex];
    self.backgroundColor = color;
}


@end
