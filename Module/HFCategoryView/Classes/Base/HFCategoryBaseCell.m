//
//  HFCategoryBaseCell.m
//  UI系列测试
//
//  Created by Macrolor on 2018/3/15.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryBaseCell.h"
#import "RTLManager.h"

@interface HFCategoryBaseCell ()
@property (nonatomic, strong) HFCategoryBaseCellModel *cellModel;
@property (nonatomic, strong) HFCategoryViewAnimator *animator;
@property (nonatomic, strong) NSMutableArray <HFCategoryCellSelectedAnimationBlock> *animationBlockArray;
@end

@implementation HFCategoryBaseCell

#pragma mark - Initialize

- (void)dealloc {
    [self.animator stop];
}

- (void)prepareForReuse {
    [super prepareForReuse];

    [self.animator stop];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeViews];
    }
    return self;
}

#pragma mark - Public

- (void)initializeViews {
    _animationBlockArray = [NSMutableArray array];

    [RTLManager horizontalFlipViewIfNeeded:self];
    [RTLManager horizontalFlipViewIfNeeded:self.contentView];
}

- (void)reloadData:(HFCategoryBaseCellModel *)cellModel {
    self.cellModel = cellModel;

    if (cellModel.isSelectedAnimationEnabled) {
        [self.animationBlockArray removeLastObject];
        if ([self checkCanStartSelectedAnimation:cellModel]) {
            self.animator = [[HFCategoryViewAnimator alloc] init];
            self.animator.duration = cellModel.selectedAnimationDuration;
        } else {
            [self.animator stop];
        }
    }
}

- (BOOL)checkCanStartSelectedAnimation:(HFCategoryBaseCellModel *)cellModel {
    BOOL canStartSelectedAnimation = ((cellModel.selectedType == HFCategoryCellSelectedTypeCode) || (cellModel.selectedType == HFCategoryCellSelectedTypeClick));
    return canStartSelectedAnimation;
}

- (void)addSelectedAnimationBlock:(HFCategoryCellSelectedAnimationBlock)block {
    [self.animationBlockArray addObject:block];
}

- (void)startSelectedAnimationIfNeeded:(HFCategoryBaseCellModel *)cellModel {
    if (cellModel.isSelectedAnimationEnabled && [self checkCanStartSelectedAnimation:cellModel]) {
        // 需要更新 isTransitionAnimating，用于处理在过滤时，禁止响应点击，避免界面异常。
        cellModel.transitionAnimating = YES;
        __weak typeof(self)weakSelf = self;
        self.animator.progressCallback = ^(CGFloat percent) {
            for (HFCategoryCellSelectedAnimationBlock block in weakSelf.animationBlockArray) {
                block(percent);
            }
        };
        self.animator.completeCallback = ^{
            cellModel.transitionAnimating = NO;
            [weakSelf.animationBlockArray removeAllObjects];
        };
        [self.animator start];
    }
}

@end
