//
//  HFCategoryTitleVerticalZoomView.m
//  HFCategoryView
//
//  Created by Macrolor on 2019/2/14.
//  Copyright © 2019 Macrolor. All rights reserved.
//

#import "HFCategoryTitleVerticalZoomView.h"
#import "HFCategoryTitleVerticalZoomCellModel.h"
#import "HFCategoryTitleVerticalZoomCell.h"
#import "HFCategoryFactory.h"

@interface HFCategoryTitleVerticalZoomView ()
@property (nonatomic, assign) CGFloat currentVerticalScale; //当前垂直方向的缩放基准值
@end

@implementation HFCategoryTitleVerticalZoomView

- (void)initializeData {
    [super initializeData];

    _maxVerticalFontScale = 2;
    _minVerticalFontScale = 1.3;
    _currentVerticalScale = _maxVerticalFontScale;
    self.cellWidthZoomEnabled = YES;
    self.cellWidthZoomScale = _maxVerticalFontScale;
    self.contentEdgeInsetLeft = 15;
    self.titleLabelZoomScale = _currentVerticalScale;
    self.titleLabelZoomEnabled = YES;
    self.selectedAnimationEnabled = YES;
    _maxVerticalCellSpacing = 20;
    _minVerticalCellSpacing = 10;
    self.cellSpacing = _maxVerticalCellSpacing;
}

- (void)listDidScrollWithVerticalHeightPercent:(CGFloat)percent {
    CGFloat currentScale = [HFCategoryFactory interpolationFrom:self.minVerticalFontScale to:self.maxVerticalFontScale percent:percent];
    BOOL shouldReloadData = NO;
    if (self.currentVerticalScale != currentScale) {
        //有变化才允许reloadData
        shouldReloadData = YES;
    }
    self.currentVerticalScale = currentScale;
    self.cellWidthZoomScale = currentScale;
    self.cellSpacing = [HFCategoryFactory interpolationFrom:self.minVerticalCellSpacing to:self.maxVerticalCellSpacing percent:percent];
    if (shouldReloadData) {
        [self refreshDataSource];
        [self refreshState];
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self.collectionView reloadData];
    }
}

- (void)setCurrentVerticalScale:(CGFloat)currentVerticalScale {
    _currentVerticalScale = currentVerticalScale;

    self.titleLabelZoomScale = currentVerticalScale;
}

- (void)setMaxVerticalCellSpacing:(CGFloat)maxVerticalCellSpacing {
    _maxVerticalCellSpacing = maxVerticalCellSpacing;

    self.cellSpacing = maxVerticalCellSpacing;
}

- (void)setMaxVerticalFontScale:(CGFloat)maxVerticalFontScale {
    _maxVerticalFontScale = maxVerticalFontScale;

    self.titleLabelZoomScale = maxVerticalFontScale;
    self.cellWidthZoomScale = maxVerticalFontScale;
}

- (Class)preferredCellClass {
    return [HFCategoryTitleVerticalZoomCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        HFCategoryTitleVerticalZoomCellModel *cellModel = [[HFCategoryTitleVerticalZoomCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshCellModel:(HFCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    HFCategoryTitleVerticalZoomCellModel *model = (HFCategoryTitleVerticalZoomCellModel *)cellModel;
    model.maxVerticalFontScale = self.maxVerticalFontScale;
}

@end
