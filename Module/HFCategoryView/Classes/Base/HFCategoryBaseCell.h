//
//  HFCategoryBaseCell.h
//  UI系列测试
//
//  Created by Macrolor on 2018/3/15.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFCategoryBaseCellModel.h"
#import "HFCategoryViewAnimator.h"
#import "HFCategoryViewDefines.h"

@interface HFCategoryBaseCell : UICollectionViewCell

@property (nonatomic, strong, readonly) HFCategoryBaseCellModel *cellModel;
@property (nonatomic, strong, readonly) HFCategoryViewAnimator *animator;

- (void)initializeViews NS_REQUIRES_SUPER;

- (void)reloadData:(HFCategoryBaseCellModel *)cellModel NS_REQUIRES_SUPER;

- (BOOL)checkCanStartSelectedAnimation:(HFCategoryBaseCellModel *)cellModel;

- (void)addSelectedAnimationBlock:(HFCategoryCellSelectedAnimationBlock)block;

- (void)startSelectedAnimationIfNeeded:(HFCategoryBaseCellModel *)cellModel;

@end
