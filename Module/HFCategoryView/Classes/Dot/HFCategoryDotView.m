//
//  HFCategoryDotView.m
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/20.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryDotView.h"

@implementation HFCategoryDotView

- (void)initializeData {
    [super initializeData];

    _relativePosition = HFCategoryDotRelativePosition_TopRight;
    _dotSize = CGSizeMake(10, 10);
    _dotCornerRadius = HFCategoryViewAutomaticDimension;
    _dotColor = [UIColor redColor];
    _dotOffset = CGPointZero;
}

- (Class)preferredCellClass {
    return [HFCategoryDotCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.titles.count];
    for (int i = 0; i < self.titles.count; i++) {
        HFCategoryDotCellModel *cellModel = [[HFCategoryDotCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = [NSArray arrayWithArray:tempArray];
}

- (void)refreshCellModel:(HFCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    HFCategoryDotCellModel *myCellModel = (HFCategoryDotCellModel *)cellModel;
    myCellModel.dotHidden = [self.dotStates[index] boolValue];
    myCellModel.relativePosition = self.relativePosition;
    myCellModel.dotSize = self.dotSize;
    myCellModel.dotColor = self.dotColor;
    myCellModel.dotOffset = self.dotOffset;
    if (self.dotCornerRadius == HFCategoryViewAutomaticDimension) {
        myCellModel.dotCornerRadius = self.dotSize.height/2;
    }else {
        myCellModel.dotCornerRadius = self.dotCornerRadius;
    }
}

@end
