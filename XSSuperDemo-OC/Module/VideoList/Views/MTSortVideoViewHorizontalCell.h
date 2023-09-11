//
//  MTSortVideoViewHorizontalCell.h
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/5.
//

#import "MTSortVideoViewCell.h"

#import "MTVideoListModel.h"
#import "MTPlayerManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTSortVideoViewHorizontalCell : MTSortVideoViewCell

@property (nonatomic, copy) void(^backClickBlock)(void);

@property (nonatomic, weak) MTPlayerManager *weak_playerManager;

- (void)autoHideOperationView;


@end

NS_ASSUME_NONNULL_END
