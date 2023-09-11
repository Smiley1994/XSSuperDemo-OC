//
//  MTPlayerManager.h
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/4.
//

#import <Foundation/Foundation.h>

#import "MTSortVideoScrollView.h"
#import "MTSortVideoHorizontalOperationView.h"

#import "MTVideoListModel.h"

NS_ASSUME_NONNULL_BEGIN

@class MTSortVideoViewCell, MTSortVideoViewVerticalCell, MTSortVideoOperationView, MTSortVideoViewHorizontalCell;

@protocol MTPlayerManagerDelegate <NSObject>

- (void)scrollViewDidPanDistance:(CGFloat)distance isEnd:(BOOL)isEnd;

- (void)cellDidClickIcon:(MTVideoListModel *)model;

- (void)cellDidClickComment:(MTVideoListModel *)model;

- (void)cellZoomBegan:(MTVideoListModel *)model;

- (void)cellZoomEnded:(MTVideoListModel *)model isFullscreen:(BOOL)isFullscreen;

@end

@interface MTPlayerManager : NSObject

@property (nonatomic, weak) id<MTPlayerManagerDelegate> delegate;

/// 竖屏滑动容器
@property (nonatomic, strong) MTSortVideoScrollView *verticalSortVideoScrollView;

/// 当前 vertical Cell
@property (nonatomic, weak) MTSortVideoViewVerticalCell *currentVerticalCell;

/// 竖屏控制层
@property (nonatomic, weak) MTSortVideoOperationView *operationView;


/// 横屏滑动容器
@property (nonatomic, strong, nullable) MTSortVideoScrollView *horizontalSortVideoScrollView;

/// 当前 horizontal Cell
@property (nonatomic, weak) MTSortVideoViewHorizontalCell *currentHorizontalCell;

/// 横屏控制层
@property (nonatomic, strong) MTSortVideoHorizontalOperationView *horizontalOperationView;

/// 页码
@property (nonatomic, assign) NSInteger page;

/// 数据源
@property (nonatomic, strong) NSMutableArray *dataSources;

@property (nonatomic, assign) BOOL isPlaying;

@property (nonatomic, assign) BOOL isAppeared;

/// 请求播放地址
- (void)requestPlayUrlWithModel:(MTVideoListModel *)model completion:(nullable void(^)(void))completion;

/// 播放视频
- (void)playVideoWithCell:(MTSortVideoViewCell *)cell index:(NSInteger)index;

/// 停止播放
- (void)stopPlayWithCell:(MTSortVideoViewCell *)cell index:(NSInteger)index;

/// 播放
- (void)play;

/// 暂停
- (void)pause;

// 旋转
- (void)rotate;

@end

NS_ASSUME_NONNULL_END
