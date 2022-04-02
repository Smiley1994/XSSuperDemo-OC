//
//  HFCategoryImageView.m
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/20.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryImageView.h"
#import "HFCategoryFactory.h"

@implementation HFCategoryImageView

- (void)dealloc {
    self.loadImageCallback = nil;
}

- (void)initializeData {
    [super initializeData];

    _imageSize = CGSizeMake(20, 20);
    _imageZoomEnabled = NO;
    _imageZoomScale = 1.2;
    _imageCornerRadius = 0;
}

- (Class)preferredCellClass {
    return [HFCategoryImageCell class];
}

- (void)refreshDataSource {
    NSUInteger count = (self.imageNames.count > 0) ? self.imageNames.count : (self.imageURLs.count > 0 ? self.imageURLs.count : 0);
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        HFCategoryImageCellModel *cellModel = [[HFCategoryImageCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = [NSArray arrayWithArray:tempArray];
}

- (void)refreshSelectedCellModel:(HFCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(HFCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];

    HFCategoryImageCellModel *myUnselectedCellModel = (HFCategoryImageCellModel *)unselectedCellModel;
    myUnselectedCellModel.imageZoomScale = 1.0;

    HFCategoryImageCellModel *myselectedCellModel = (HFCategoryImageCellModel *)selectedCellModel;
    myselectedCellModel.imageZoomScale = self.imageZoomScale;
}

- (void)refreshCellModel:(HFCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    HFCategoryImageCellModel *myCellModel = (HFCategoryImageCellModel *)cellModel;
    myCellModel.loadImageCallback = self.loadImageCallback;
    myCellModel.imageSize = self.imageSize;
    myCellModel.imageCornerRadius = self.imageCornerRadius;
    if (self.imageNames && self.imageNames.count != 0) {
        myCellModel.imageName = self.imageNames[index];
    } else if (self.imageURLs && self.imageURLs.count != 0) {
        myCellModel.imageURL = self.imageURLs[index];
    }
    if (self.selectedImageNames && self.selectedImageNames != 0) {
        myCellModel.selectedImageName = self.selectedImageNames[index];
    } else if (self.selectedImageURLs && self.selectedImageURLs != 0) {
        myCellModel.selectedImageURL = self.selectedImageURLs[index];
    }
    myCellModel.imageZoomEnabled = self.imageZoomEnabled;
    myCellModel.imageZoomScale = ((index == self.selectedIndex) ? self.imageZoomScale : 1.0);
}

- (void)refreshLeftCellModel:(HFCategoryBaseCellModel *)leftCellModel rightCellModel:(HFCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];

    HFCategoryImageCellModel *leftModel = (HFCategoryImageCellModel *)leftCellModel;
    HFCategoryImageCellModel *rightModel = (HFCategoryImageCellModel *)rightCellModel;

    if (self.isImageZoomEnabled) {
        leftModel.imageZoomScale = [HFCategoryFactory interpolationFrom:self.imageZoomScale to:1.0 percent:ratio];
        rightModel.imageZoomScale = [HFCategoryFactory interpolationFrom:1.0 to:self.imageZoomScale percent:ratio];
    }
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    if (self.cellWidth == HFCategoryViewAutomaticDimension) {
        return self.imageSize.width;
    }
    return self.cellWidth;
}

@end
