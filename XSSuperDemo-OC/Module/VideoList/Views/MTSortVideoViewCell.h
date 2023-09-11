//
//  MTSortVideoViewCell.h
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/5.
//

#import "MTVideoViewCell.h"
#import "MTSortVideoOperationView.h"

#import "MTVideoListModel.h"
#import "MTPlayerManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTSortVideoViewCell : MTVideoViewCell

@property (nonatomic, strong) MTVideoListModel *model;

@property (nonatomic, strong) UIImageView *coverImgView;

- (void)initUI;

- (void)setupModel:(MTVideoListModel *)model;

- (void)resetView;


@end

NS_ASSUME_NONNULL_END
