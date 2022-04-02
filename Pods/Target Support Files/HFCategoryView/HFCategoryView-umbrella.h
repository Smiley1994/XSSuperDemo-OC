#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HFCategoryView.h"
#import "HFCategoryBaseCell.h"
#import "HFCategoryBaseCellModel.h"
#import "HFCategoryBaseView.h"
#import "HFCategoryCollectionView.h"
#import "HFCategoryFactory.h"
#import "HFCategoryIndicatorParamsModel.h"
#import "HFCategoryIndicatorProtocol.h"
#import "HFCategoryListContainerRTLCell.h"
#import "HFCategoryListContainerView.h"
#import "HFCategoryViewAnimator.h"
#import "HFCategoryViewDefines.h"
#import "UIColor+HFAdd.h"
#import "HFCategoryDotCell.h"
#import "HFCategoryDotCellModel.h"
#import "HFCategoryDotView.h"
#import "HFCategoryImageCell.h"
#import "HFCategoryImageCellModel.h"
#import "HFCategoryImageView.h"
#import "HFCategoryIndicatorCell.h"
#import "HFCategoryIndicatorCellModel.h"
#import "HFCategoryIndicatorView.h"
#import "HFCategoryIndicatorBackgroundView.h"
#import "HFCategoryIndicatorBallView.h"
#import "HFCategoryIndicatorComponentView.h"
#import "HFCategoryIndicatorDotLineView.h"
#import "HFCategoryIndicatorImageView.h"
#import "HFCategoryIndicatorLineView.h"
#import "HFCategoryIndicatorRainbowLineView.h"
#import "HFCategoryIndicatorTriangleView.h"
#import "HFCategoryNumberCell.h"
#import "HFCategoryNumberCellModel.h"
#import "HFCategoryNumberView.h"
#import "RTLManager.h"
#import "HFCategoryTitleCell.h"
#import "HFCategoryTitleCellModel.h"
#import "HFCategoryTitleView.h"
#import "HFCategoryTitleImageCell.h"
#import "HFCategoryTitleImageCellModel.h"
#import "HFCategoryTitleImageView.h"
#import "HFCategoryTitleVerticalZoomCell.h"
#import "HFCategoryTitleVerticalZoomCellModel.h"
#import "HFCategoryTitleVerticalZoomView.h"

FOUNDATION_EXPORT double HFCategoryViewVersionNumber;
FOUNDATION_EXPORT const unsigned char HFCategoryViewVersionString[];

