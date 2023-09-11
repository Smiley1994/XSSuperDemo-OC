//
//  MTSortVideoOperationView.h
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/5.
//

#import <UIKit/UIKit.h>
#import <ZFPlayer/ZFPlayer.h>

#import "MTVideoListModel.h"



NS_ASSUME_NONNULL_BEGIN

@class MTSortVideoOperationView;

@protocol MTSortVideoOperationViewDelegate <NSObject>

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
- (void)videoOperationView:(MTSortVideoOperationView *)operationView didClickFullScreen:(MTVideoListModel *)model;

@end

@interface MTSortVideoOperationView : UIView <ZFPlayerMediaControl>

@property (nonatomic, weak) id<MTSortVideoOperationViewDelegate> delegate;

@property (nonatomic, strong) MTVideoListModel *model;

- (void)willBeginDragging;

- (void)didEndDragging;

@end

NS_ASSUME_NONNULL_END
