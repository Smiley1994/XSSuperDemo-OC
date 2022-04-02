//
//  HFCategoryTitleImageView.m
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/8.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryTitleImageView.h"
#import "HFCategoryTitleImageCell.h"
#import "HFCategoryTitleImageCellModel.h"
#import "HFCategoryFactory.h"

@implementation HFCategoryTitleImageView

- (void)dealloc {
    self.loadImageCallback = nil;
}

- (void)initializeData {
    [super initializeData];

    _imageSize = CGSizeMake(20, 20);
    _titleImageSpacing = 5;
    _imageZoomEnabled = NO;
    _imageZoomScale = 1.2;
}

- (Class)preferredCellClass {
    return [HFCategoryTitleImageCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.titles.count];
    for (int i = 0; i < self.titles.count; i++) {
        HFCategoryTitleImageCellModel *cellModel = [[HFCategoryTitleImageCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = [NSArray arrayWithArray:tempArray];
    
    if (!self.imageTypes || (self.imageTypes.count == 0)) {
        NSMutableArray *types = [NSMutableArray arrayWithCapacity:self.titles.count];
        for (int i = 0; i< self.titles.count; i++) {
            [types addObject:@(HFCategoryTitleImageType_LeftImage)];
        }
        self.imageTypes = [NSArray arrayWithArray:types];
    }
}

- (void)refreshCellModel:(HFCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    HFCategoryTitleImageCellModel *myCellModel = (HFCategoryTitleImageCellModel *)cellModel;
    myCellModel.loadImageCallback = self.loadImageCallback;
    myCellModel.imageType = [self.imageTypes[index] integerValue];
    myCellModel.imageSize = self.imageSize;
    myCellModel.titleImageSpacing = self.titleImageSpacing;
    if (self.imageInfoArray && self.imageInfoArray.count != 0) {
        myCellModel.imageInfo = self.imageInfoArray[index];
    }else if (self.imageNames && self.imageNames.count != 0) {
        myCellModel.imageName = self.imageNames[index];
    }else if (self.imageURLs && self.imageURLs.count != 0) {
        myCellModel.imageURL = self.imageURLs[index];
    }
    if (self.selectedImageInfoArray && self.selectedImageInfoArray.count != 0) {
        myCellModel.selectedImageInfo = self.selectedImageInfoArray[index];
    }else if (self.selectedImageNames && self.selectedImageNames.count != 0) {
        myCellModel.selectedImageName = self.selectedImageNames[index];
    }else if (self.selectedImageURLs && self.selectedImageURLs.count != 0) {
        myCellModel.selectedImageURL = self.selectedImageURLs[index];
    }
    myCellModel.imageZoomEnabled = self.imageZoomEnabled;
    myCellModel.imageZoomScale = ((index == self.selectedIndex) ? self.imageZoomScale : 1.0);
}

- (void)refreshSelectedCellModel:(HFCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(HFCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];

    HFCategoryTitleImageCellModel *myUnselectedCellModel = (HFCategoryTitleImageCellModel *)unselectedCellModel;
    myUnselectedCellModel.imageZoomScale = 1.0;

    HFCategoryTitleImageCellModel *myselectedCellModel = (HFCategoryTitleImageCellModel *)selectedCellModel;
    myselectedCellModel.imageZoomScale = self.imageZoomScale;
}

- (void)refreshLeftCellModel:(HFCategoryBaseCellModel *)leftCellModel rightCellModel:(HFCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];

    HFCategoryTitleImageCellModel *leftModel = (HFCategoryTitleImageCellModel *)leftCellModel;
    HFCategoryTitleImageCellModel *rightModel = (HFCategoryTitleImageCellModel *)rightCellModel;

    if (self.isImageZoomEnabled) {
        leftModel.imageZoomScale = [HFCategoryFactory interpolationFrom:self.imageZoomScale to:1.0 percent:ratio];
        rightModel.imageZoomScale = [HFCategoryFactory interpolationFrom:1.0 to:self.imageZoomScale percent:ratio];
    }
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    if (self.cellWidth == HFCategoryViewAutomaticDimension) {
        CGFloat titleWidth = [super preferredCellWidthAtIndex:index];
        HFCategoryTitleImageType type = [self.imageTypes[index] integerValue];
        CGFloat cellWidth = 0;
        switch (type) {
            case HFCategoryTitleImageType_OnlyTitle:
                cellWidth = titleWidth;
                break;
            case HFCategoryTitleImageType_OnlyImage:
                cellWidth = self.imageSize.width;
                break;
            case HFCategoryTitleImageType_LeftImage:
            case HFCategoryTitleImageType_RightImage:
                cellWidth = titleWidth + self.titleImageSpacing + self.imageSize.width;
                break;
            case HFCategoryTitleImageType_TopImage:
            case HFCategoryTitleImageType_BottomImage:
                cellWidth = MAX(titleWidth, self.imageSize.width);
                break;
        }
        return cellWidth;
    }
    return self.cellWidth;
}

@end
