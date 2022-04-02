//
//  HFCategoryNumberView.m
//  DQGuess
//
//  Created by Macrolor on 2018/4/9.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryNumberView.h"

@implementation HFCategoryNumberView

- (void)dealloc {
    self.numberStringFormatterBlock = nil;
}

- (void)initializeData {
    [super initializeData];

    self.cellSpacing = 25;
    _numberTitleColor = [UIColor whiteColor];
    _numberBackgroundColor = [UIColor colorWithRed:241/255.0 green:147/255.0 blue:95/255.0 alpha:1];
    _numberLabelHeight = 14;
    _numberLabelWidthIncrement = 10;
    _numberLabelFont = [UIFont systemFontOfSize:11];
    _shouldMakeRoundWhenSingleNumber = NO;
}

- (Class)preferredCellClass {
    return [HFCategoryNumberCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.titles.count];
    for (int i = 0; i < self.titles.count; i++) {
        HFCategoryNumberCellModel *cellModel = [[HFCategoryNumberCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = [NSArray arrayWithArray:tempArray];
}

- (void)refreshCellModel:(HFCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    HFCategoryNumberCellModel *myCellModel = (HFCategoryNumberCellModel *)cellModel;
    myCellModel.count = [self.counts[index] integerValue];
    if (self.numberStringFormatterBlock != nil) {
        myCellModel.numberString = self.numberStringFormatterBlock(myCellModel.count);
    }else {
        myCellModel.numberString = [NSString stringWithFormat:@"%ld", (long)myCellModel.count];
    }
    myCellModel.numberBackgroundColor = self.numberBackgroundColor;
    myCellModel.numberTitleColor = self.numberTitleColor;
    myCellModel.numberLabelHeight = self.numberLabelHeight;
    myCellModel.numberLabelOffset = self.numberLabelOffset;
    myCellModel.numberLabelWidthIncrement = self.numberLabelWidthIncrement;
    myCellModel.numberLabelFont = self.numberLabelFont;
    myCellModel.shouldMakeRoundWhenSingleNumber = self.shouldMakeRoundWhenSingleNumber;
}

@end
