//
//  MTSortVideoViewVerticalCell.h
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/6.
//

#import "MTSortVideoViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MTSortVideoViewVerticalCellDelegate <NSObject>

@optional

///// clike icon
//- (void)sortVideoViewCell:(MTSortVideoViewCell *)operationView didClickIconWithModel:(MTVideoListModel *)model;
///// click like
//- (void)sortVideoViewCell:(MTSortVideoViewCell *)operationView didClickLike:(MTVideoListModel *)model;
///// click comment
//- (void)sortVideoViewCell:(MTSortVideoViewCell *)operationView didClickComment:(MTVideoListModel *)model;
///// click share
//- (void)sortVideoViewCell:(MTSortVideoViewCell *)operationView didClickShare:(MTVideoListModel *)model;
///// click share
//- (void)sortVideoViewCell:(MTSortVideoViewCell *)operationView didClickDanmu:(MTVideoListModel *)model;
/// click full screen
- (void)sortVideoViewCell:(MTSortVideoViewCell *)operationView didClickFullScreen:(MTVideoListModel *)model;

@end

@interface MTSortVideoViewVerticalCell : MTSortVideoViewCell

@property (nonatomic, strong) MTSortVideoOperationView *operationView;

@property (nonatomic, weak) MTPlayerManager *weak_playerManager;

@property (nonatomic, weak) id<MTSortVideoViewVerticalCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
