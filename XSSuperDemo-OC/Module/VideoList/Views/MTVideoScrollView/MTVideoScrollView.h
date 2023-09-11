//
//  MTVideoScrollView.h
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/4.
//

#import <UIKit/UIKit.h>
#import "MTVideoViewCell.h"

@class MTVideoScrollView;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - MTVideoScrollViewDataSource

@protocol MTVideoScrollViewDataSource <NSObject>

// 内容总数
- (NSInteger)numberOfRowsInScrollView:(MTVideoScrollView *)scrollView;

// 设置cell
- (MTVideoViewCell *)scrollView:(MTVideoScrollView *)scrollView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - MTVideoScrollViewDelegate

@protocol MTVideoScrollViewDelegate <NSObject, UIScrollViewDelegate>

@optional

/// cell 即将显示时调用，可用于请求播放信息
/// 注意：1、此时的cell并不一定等于最终显示的cell，慎用 2、在快速滑动时，此方法可能不会回调所有的index
- (void)scrollView:(MTVideoScrollView *)scrollView willDisplayCell:(MTVideoViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

/// cell 结束显示时调用，可用于结束播放
- (void)scrollView:(MTVideoScrollView *)scrollView didEndDisplayingCell:(MTVideoViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

/// 结束滑动时显示的cell，可在这里开始播放
- (void)scrollView:(MTVideoScrollView *)scrollView didEndScrollingCell:(MTVideoViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - MTVideoScrollView

@interface MTVideoScrollView : UIScrollView

/// 数据源
@property (nonatomic, weak, nullable) id<MTVideoScrollViewDataSource> dataSource;

/// 代理
@property (nonatomic, weak, nullable) id<MTVideoScrollViewDelegate> delegate;

/// 默认索引
@property (nonatomic, assign) NSInteger defaultIndex;

/// 当前索引
@property (nonatomic, assign, readonly) NSInteger currentIndex;

/// 当前显示的cell
@property (nonatomic, weak, readonly) MTVideoViewCell *currentCell;

/// 可视cells
@property (nonatomic, readonly) NSArray<__kindof UIView *> *visibleCells;

/// 获取行数
- (NSInteger)numberOfRows;

/// 获取cell对应的indexPath
- (nullable NSIndexPath *)indexPathForCell:(MTVideoViewCell *)cell;

/// 获取indexPath对应的cell
- (nullable __kindof MTVideoViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/// 注册cell
- (void)registerNib:(nullable UINib *)nib forCellReuseIdentifier:(nonnull NSString *)identifier;
- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(nonnull NSString *)identifier;

/// 获取可复用的cell
- (__kindof MTVideoViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(nonnull NSIndexPath *)indexPath;

/// 刷新数据
- (void)reloadData;

/// 切换到指定索引页面，无动画
- (void)scrollToPageWithIndex:(NSInteger)index;

/// 切换到下个页面，有动画
- (void)scrollToNextPage;

@end

NS_ASSUME_NONNULL_END
