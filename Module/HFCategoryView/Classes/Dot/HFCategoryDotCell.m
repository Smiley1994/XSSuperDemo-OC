//
//  HFCategoryDotCell.m
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/20.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryDotCell.h"
#import "HFCategoryDotCellModel.h"

@interface HFCategoryDotCell ()
@property (nonatomic, strong) UIView *dot;
@end

@implementation HFCategoryDotCell

- (void)initializeViews {
    [super initializeViews];

    _dot = [[UIView alloc] init];
    [self.contentView addSubview:self.dot];
    self.dot.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)reloadData:(HFCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    HFCategoryDotCellModel *myCellModel = (HFCategoryDotCellModel *)cellModel;
    self.dot.hidden = !myCellModel.dotHidden;
    self.dot.backgroundColor = myCellModel.dotColor;
    self.dot.layer.cornerRadius = myCellModel.dotCornerRadius;
    [NSLayoutConstraint deactivateConstraints:self.dot.constraints];
    [self.dot.widthAnchor constraintEqualToConstant:myCellModel.dotSize.width].active = YES;
    [self.dot.heightAnchor constraintEqualToConstant:myCellModel.dotSize.height].active = YES;
    switch (myCellModel.relativePosition) {
        case HFCategoryDotRelativePosition_TopLeft:
        {
            [self.dot.centerXAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor constant:myCellModel.dotOffset.x].active = YES;
            [self.dot.centerYAnchor constraintEqualToAnchor:self.titleLabel.topAnchor constant:myCellModel.dotOffset.y].active = YES;
        }
            break;
        case HFCategoryDotRelativePosition_TopRight:
        {
            [self.dot.centerXAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor constant:myCellModel.dotOffset.x].active = YES;
            [self.dot.centerYAnchor constraintEqualToAnchor:self.titleLabel.topAnchor constant:myCellModel.dotOffset.y].active = YES;
        }
            break;
        case HFCategoryDotRelativePosition_BottomLeft:
        {
            [self.dot.centerXAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor constant:myCellModel.dotOffset.x].active = YES;
            [self.dot.centerYAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:myCellModel.dotOffset.y].active = YES;
        }
            break;
        case HFCategoryDotRelativePosition_BottomRight:
        {
            [self.dot.centerXAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor constant:myCellModel.dotOffset.x].active = YES;
            [self.dot.centerYAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:myCellModel.dotOffset.y].active = YES;
        }
            break;
    }
}

@end
