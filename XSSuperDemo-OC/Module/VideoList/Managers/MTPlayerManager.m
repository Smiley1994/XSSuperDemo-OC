//
//  MTPlayerManager.m
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/4.
//

#import "MTPlayerManager.h"
#import "MTSortVideoScrollView.h"
#import "MTSortVideoViewVerticalCell.h"
#import "MTSortVideoViewHorizontalCell.h"

#import "GKRotationManager.h"

#import <AFNetworking/AFNetworking.h>
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <YYKit/YYKit.h>

@interface MTPlayerManager () <MTVideoScrollViewDataSource, MTSortVideoScrollViewDelegate, MTSortVideoViewVerticalCellDelegate>

@property (nonatomic, strong) ZFPlayerController *player;

/// 控制屏幕方向
@property (nonatomic, strong) GKRotationManager *rotationManager;

@property (nonatomic, assign) BOOL isSeeking;

@end

@implementation MTPlayerManager

- (instancetype)init {
    if (self = [super init]) {
        [self initPlayer];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"MTPlayerManager dealloc");
    [self stop];
}

- (void)reset {
    [self stop];
}

- (void)initPlayer {
    // 初始化播放器
    ZFAVPlayerManager *manager = [[ZFAVPlayerManager alloc] init];
    manager.shouldAutoPlay = NO; // 自动播放
    
    ZFPlayerController *player = [[ZFPlayerController alloc] init];
    player.currentPlayerManager = manager;
    player.disableGestureTypes = ZFPlayerDisableGestureTypesPan | ZFPlayerDisableGestureTypesPinch;
    player.allowOrentitaionRotation = NO; // 禁止自动旋转
    self.player = player;
    
    // 播放结束回调
    __weak typeof(self) weakSelf = self;
    player.playerDidToEnd = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
        
        [weakSelf.player.currentPlayerManager replay];
        
    };
    
    // 播放失败回调
    player.playerPlayFailed = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, id  _Nonnull error) {
        // ignore
    };
    
    // 加载状态
    player.playerLoadStateChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, ZFPlayerLoadState loadState) {
        // ignore
    };
    
    // 播放时间
    player.playerPlayTimeChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSTimeInterval currentTime, NSTimeInterval duration) {
        // ignore
    };
    
    // 方向即将改变
    player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        
        weakSelf.player.controlView.hidden = YES;
        
    };
    
    // 方向已经改变
    player.orientationDidChanged = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
       
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (isFullScreen) {
            // 设置横屏控制层
            strongSelf.horizontalOperationView.hidden = NO;
            strongSelf.player.controlView = self.horizontalOperationView;
            
        }else {
            // 设置竖屏控制层
            strongSelf.operationView.hidden = NO;
            strongSelf.player.controlView = strongSelf.operationView;
        }
        
    };
    
    // 控制屏幕方向
    // ....
    self.rotationManager = [GKRotationManager rotationManager];
    self.rotationManager.contentView = self.player.currentPlayerManager.view;
    self.horizontalOperationView.rotationManager = self.rotationManager;
    
    // 即将旋转时调用
    self.rotationManager.orientationWillChange = ^(BOOL isFullscreen) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
    
        strongSelf.player.controlView.hidden = YES;
        
        if (isFullscreen) {
            
            // self.horizontalOperationView doing....

        }else {
            
            strongSelf.player.currentPlayerManager.view.backgroundColor = UIColor.clearColor;

            strongSelf.operationView.hidden = NO;
            
            if (strongSelf.horizontalSortVideoScrollView) {
                UIView *superview = strongSelf.horizontalSortVideoScrollView.superview;
                [superview addSubview:strongSelf.rotationManager.contentView];
                [strongSelf.horizontalSortVideoScrollView removeFromSuperview];
                strongSelf.horizontalSortVideoScrollView = nil;
                strongSelf.currentHorizontalCell = nil;
            }
        }
        
    };
    
    // 旋转结束时调用
    self.rotationManager.orientationDidChanged = ^(BOOL isFullscreen) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (isFullscreen) {
            
            strongSelf.horizontalOperationView.hidden = NO;
            
            if (!strongSelf.horizontalSortVideoScrollView) {
                [strongSelf initHorizontalSortVideoScrollView];
                UIView *superview = strongSelf.rotationManager.contentView.superview;
                [superview addSubview:strongSelf.horizontalSortVideoScrollView];
                strongSelf.horizontalSortVideoScrollView.defaultIndex = strongSelf.verticalSortVideoScrollView.currentIndex;
                [strongSelf.horizontalSortVideoScrollView reloadData];
            }

            strongSelf.player.controlView = strongSelf.horizontalOperationView;
            [strongSelf.currentVerticalCell resetView];
            
        }else {
           
            strongSelf.operationView.hidden = NO;
            
            strongSelf.horizontalOperationView.hidden = YES;
            
            strongSelf.player.controlView = strongSelf.operationView;
            
            if (strongSelf.player.containerView != strongSelf.currentVerticalCell.coverImgView) {
                strongSelf.player.containerView = strongSelf.currentVerticalCell.coverImgView;
            }
            
            strongSelf.player.currentPlayerManager.view.backgroundColor = UIColor.blackColor;
        }
    };
    
}

- (void)initHorizontalSortVideoScrollView {
    self.horizontalSortVideoScrollView = [[MTSortVideoScrollView alloc] init];
    self.horizontalSortVideoScrollView.backgroundColor = UIColor.blackColor;
    self.horizontalSortVideoScrollView.dataSource = self;
    self.horizontalSortVideoScrollView.delegate = self;
    [self.horizontalSortVideoScrollView registerClass:MTSortVideoViewHorizontalCell.class forCellReuseIdentifier:@"MTSortVideoViewHorizontalCellIdentifyer"];
}

- (void)play {
    if (self.isPlaying) return;
    [self.player.currentPlayerManager play];
}

- (void)pause {
    if (!self.isPlaying) return;
    [self.player.currentPlayerManager pause];
}

- (void)stop {
    [self.player.currentPlayerManager stop];
    self.player = nil;
}
    
- (void)rotate {
    [self.rotationManager rotate];
}

- (BOOL)isPlaying {
    return self.player.currentPlayerManager.isPlaying;
}

- (void)requestPlayUrlWithModel:(MTVideoListModel *)model completion:(nullable void (^)(void))completion {
    
    if (model.play_url.length > 0) return;
    
    if (model.task) {
        [model.task cancel];
        model.task = nil;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *url = [NSString stringWithFormat:@"https://haokan.baidu.com/v?vid=%@&_format=json&", model.video_id];
    
    model.task = [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errno"] integerValue] == 0) {
            NSDictionary *videoMeta = responseObject[@"data"][@"apiData"][@"curVideoMeta"];
            model.play_url = videoMeta[@"playurl"];
            model.comment = videoMeta[@"comment"];
            model.like = videoMeta[@"fmlike_num"];
            
            __block NSInteger index = 0;
            __block BOOL exist = NO;
            [self.dataSources enumerateObjectsUsingBlock:^(MTVideoListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.video_id isEqualToString:model.video_id]) {
                    index = idx;
                    exist = YES;
                    *stop = YES;
                }
            }];
            [self.dataSources replaceObjectAtIndex:index withObject:model];
            model.task = nil;
            !completion ?: completion();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        model.task = nil;
        NSLog(@"播放地址请求失败");
    }];
    
}

- (void)playVideoWithCell:(MTSortVideoViewCell *)cell index:(NSInteger)index {
    
    MTVideoListModel *model = self.dataSources[index];
    
    self.horizontalOperationView.model = model;
    
    if ([cell isKindOfClass:MTSortVideoViewVerticalCell.class]) {
        self.currentVerticalCell = (MTSortVideoViewVerticalCell *)cell;
        self.operationView = self.currentVerticalCell.operationView;
        self.rotationManager.containerView = cell.coverImgView;
        // 如果全屏状态 return
        if (self.rotationManager.isFullscreen) return;
        
    }else {
        self.currentHorizontalCell = (MTSortVideoViewHorizontalCell *)cell;
//        [self.horizontalCell autoHideOperationView];
        [self.verticalSortVideoScrollView scrollToPageWithIndex:index];
    }
    
    // 设置播放内容视图
    if (self.player.containerView != cell.coverImgView) {
        self.player.containerView = cell.coverImgView;
    }
    
    // 设置播放器控制层视图
    if ([cell isKindOfClass:MTSortVideoViewVerticalCell.class]) {
        MTSortVideoViewVerticalCell *verticalCell = (MTSortVideoViewVerticalCell *)cell;
        if (self.player.controlView != verticalCell.operationView) {
            self.player.controlView = verticalCell.operationView;
            self.operationView = verticalCell.operationView;
        }
    }
    
    // 设置封面图片
    id<ZFPlayerMediaPlayback> manager = self.player.currentPlayerManager;
    [manager.view.coverImageView setImageWithURL:[NSURL URLWithString:model.poster_small] options:YYWebImageOptionProgressive];
    
    if (model.play_url.length > 0) {
        // 播放内容一致，不做处理
        if ([self.player.assetURL.absoluteString isEqualToString:model.play_url]) return;
        
        // 设置播放地址
        self.player.assetURL = [NSURL URLWithString:model.play_url];

        [self.player.currentPlayerManager play];
        
    }else {
        __weak typeof(self) weakSelf = self;
        [self requestPlayUrlWithModel:model completion:^{
            __strong typeof(self) strongSelf = weakSelf;
            // 播放内容一致，不做处理
            if ([strongSelf.player.assetURL.absoluteString isEqualToString:model.play_url]) return;
            
            // 设置播放地址
            strongSelf.player.assetURL = [NSURL URLWithString:model.play_url];

            [strongSelf.player.currentPlayerManager play];
            
        }];
    }

}

- (void)stopPlayWithCell:(MTSortVideoViewCell *)cell index:(NSInteger)index {
    
    MTVideoListModel *model = self.dataSources[index];
    if (![self.player.assetURL.absoluteString isEqualToString:model.play_url]) {
        return;
    }
    
    [self.player stop];
    
    if ([self.player.controlView isKindOfClass:MTSortVideoViewVerticalCell.class]) {
        [self.player.controlView removeFromSuperview];
        self.player.controlView = nil;
    }
    
    [cell resetView];
    
}

#pragma mark - MTVideoScrollViewDataSource

- (NSInteger)numberOfRowsInScrollView:(MTVideoScrollView *)scrollView {
    return self.dataSources.count;
}

- (MTVideoViewCell *)scrollView:(MTVideoScrollView *)scrollView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MTVideoListModel *model = self.dataSources[indexPath.row];
    
    if (scrollView == self.verticalSortVideoScrollView) {
        MTSortVideoViewVerticalCell *cell = [scrollView dequeueReusableCellWithIdentifier:@"MTSortVideoViewVerticalCellIdentifyer" forIndexPath:indexPath];
        cell.delegate = self;
        cell.weak_playerManager = self;
        [cell setupModel:model];
        return cell;
        
    } else {
        
        MTSortVideoViewHorizontalCell *cell = [scrollView dequeueReusableCellWithIdentifier:@"MTSortVideoViewHorizontalCellIdentifyer" forIndexPath:indexPath];

        [cell setupModel:model];
        @weakify(self);
        cell.backClickBlock = ^{
            @strongify(self);
            [self rotate];
        };

        return cell;
    }

    
}

#pragma mark - MTSortVideoScrollViewDelegate

- (void)scrollView:(MTVideoScrollView *)scrollView didEndScrollingCell:(MTVideoViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self playVideoWithCell:(MTSortVideoViewCell *)cell index:indexPath.row];
}

- (void)scrollView:(MTVideoScrollView *)scrollView didEndDisplayingCell:(MTVideoViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self stopPlayWithCell:(MTSortVideoViewCell *)cell index:indexPath.row];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.verticalSortVideoScrollView) {
        if (self.verticalSortVideoScrollView.currentIndex == 0 && scrollView.contentOffset.y < 0) {
            self.verticalSortVideoScrollView.contentOffset = CGPointZero;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.operationView willBeginDragging];
    
    [self.horizontalOperationView willBeginDragging];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self.operationView didEndDragging];
    
    [self.horizontalOperationView didEndDragging];
    
}

- (void)scrollView:(MTSortVideoScrollView *)scrollView didPanWithDistance:(CGFloat)distance isEnd:(BOOL)isEnd {
    
    if ([self.delegate respondsToSelector:@selector(scrollViewDidPanDistance:isEnd:)]) {
        [self.delegate scrollViewDidPanDistance:distance isEnd:isEnd];
    }
    
}

#pragma mark - MTSortVideoOperationViewDelegate

- (void)sortVideoViewCell:(MTSortVideoViewCell *)operationView didClickFullScreen:(MTVideoListModel *)model {
    
    [self rotate];
    
}

#pragma mark -Lazy

- (MTSortVideoScrollView *)verticalSortVideoScrollView {
    if (!_verticalSortVideoScrollView) {
        _verticalSortVideoScrollView = [[MTSortVideoScrollView alloc] init];
        _verticalSortVideoScrollView.dataSource = self;
        _verticalSortVideoScrollView.delegate = self;
        _verticalSortVideoScrollView.backgroundColor = UIColor.blackColor;
        [_verticalSortVideoScrollView registerClass:[MTSortVideoViewVerticalCell class] forCellReuseIdentifier:@"MTSortVideoViewVerticalCellIdentifyer"];
        [_verticalSortVideoScrollView addPanGesture];
    }
    return _verticalSortVideoScrollView;
}

- (MTSortVideoHorizontalOperationView *)horizontalOperationView {
    if (!_horizontalOperationView) {
        _horizontalOperationView = [[MTSortVideoHorizontalOperationView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        
    }
    return _horizontalOperationView;;
}

- (NSMutableArray *)dataSources {
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

@end



