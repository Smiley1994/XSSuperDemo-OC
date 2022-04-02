//
//  HFCategoryIndicatorCell.m
//  DQGuess
//
//  Created by Macrolor on 2018/7/25.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryIndicatorCell.h"
#import "HFCategoryIndicatorCellModel.h"

@interface HFCategoryIndicatorCell ()
@property (nonatomic, strong) UIView *separatorLine;
@end

@implementation HFCategoryIndicatorCell

- (void)initializeViews {
    [super initializeViews];

    self.separatorLine = [[UIView alloc] init];
    self.separatorLine.hidden = YES;
    [self.contentView addSubview:self.separatorLine];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    HFCategoryIndicatorCellModel *model = (HFCategoryIndicatorCellModel *)self.cellModel;
    CGFloat lineWidth = model.separatorLineSize.width;
    CGFloat lineHeight = model.separatorLineSize.height;

    self.separatorLine.frame = CGRectMake(self.bounds.size.width - lineWidth + self.cellModel.cellSpacing/2, (self.bounds.size.height - lineHeight)/2.0, lineWidth, lineHeight);
}

- (void)reloadData:(HFCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    HFCategoryIndicatorCellModel *model = (HFCategoryIndicatorCellModel *)cellModel;
    self.separatorLine.backgroundColor = model.separatorLineColor;
    self.separatorLine.hidden = !model.isSepratorLineShowEnabled;

    if (model.isCellBackgroundColorGradientEnabled) {
        if (model.isSelected) {
            self.contentView.backgroundColor = model.cellBackgroundSelectedColor;
        }else {
            self.contentView.backgroundColor = model.cellBackgroundUnselectedColor;
        }
    }
}

@end
