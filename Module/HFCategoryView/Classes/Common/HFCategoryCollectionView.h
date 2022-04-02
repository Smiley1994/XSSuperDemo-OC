//
//  HFCategoryCollectionView.h
//  UI系列测试
//
//  Created by Macrolor on 2018/3/21.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFCategoryIndicatorProtocol.h"
@class HFCategoryCollectionView;

@protocol HFCategoryCollectionViewGestureDelegate <NSObject>
@optional
- (BOOL)categoryCollectionView:(HFCategoryCollectionView *)collectionView gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;
- (BOOL)categoryCollectionView:(HFCategoryCollectionView *)collectionView gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
@end

@interface HFCategoryCollectionView : UICollectionView

@property (nonatomic, strong) NSArray <UIView<HFCategoryIndicatorProtocol> *> *indicators;
@property (nonatomic, weak) id<HFCategoryCollectionViewGestureDelegate> gestureDelegate;

@end
