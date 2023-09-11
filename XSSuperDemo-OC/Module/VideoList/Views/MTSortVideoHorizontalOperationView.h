//
//  MTSortVideoHorizontalOperationView.h
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/6.
//

#import <UIKit/UIKit.h>
#import <ZFPlayer/ZFPlayer.h>

#import "MTVideoListModel.h"

#import "GKRotationManager.h"

NS_ASSUME_NONNULL_BEGIN

@class MTSortVideoHorizontalOperationView;

@protocol MTSortVideoHorizontalOperationViewDelegate <NSObject>

///// clike icon
//- (void)videoOperationView:(MTSortVideoOperationView *)operationView didClickIconWithModel:(MTVideoListModel *)model;
///// click like
//- (void)videoOperationView:(MTSortVideoOperationView *)operationView didClickLike:(MTVideoListModel *)model;
///// click comment
//- (void)videoOperationView:(MTSortVideoOperationView *)operationView didClickComment:(MTVideoListModel *)model;
///// click share
//- (void)videoOperationView:(MTSortVideoOperationView *)operationView didClickShare:(MTVideoListModel *)model;
///// click share
//- (void)videoOperationView:(MTSortVideoOperationView *)operationView didClickDanmu:(MTVideoListModel *)model;
/// click full screen
- (void)videoOperationView:(MTSortVideoHorizontalOperationView *)operationView didClickFullScreen:(MTVideoListModel *)model;

@end

@interface MTSortVideoHorizontalOperationView : UIView <ZFPlayerMediaControl>

@property (nonatomic, weak) id<MTSortVideoHorizontalOperationViewDelegate> delegate;

@property (nonatomic, strong) MTVideoListModel *model;

@property (nonatomic, weak) GKRotationManager *rotationManager;

- (void)willBeginDragging;

- (void)didEndDragging;

@end

NS_ASSUME_NONNULL_END
