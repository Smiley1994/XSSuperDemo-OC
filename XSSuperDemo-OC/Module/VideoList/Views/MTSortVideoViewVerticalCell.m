//
//  MTSortVideoViewVerticalCell.m
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/6.
//

#import "MTSortVideoViewVerticalCell.h"

#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>

@interface MTSortVideoViewVerticalCell () <MTSortVideoOperationViewDelegate>

@end

@implementation MTSortVideoViewVerticalCell

- (void)initUI {
    
    [self addSubview:self.coverImgView];
    [self.coverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.coverImgView addSubview:self.operationView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.coverImgView.frame = self.bounds;
    self.operationView.frame = self.coverImgView.bounds;
}

- (void)setupModel:(MTVideoListModel *)model {
    [super setupModel:model];
    
    self.operationView.model = model;
    
    if (self.weak_playerManager) {
        [self.weak_playerManager requestPlayUrlWithModel:model completion:nil];
    }
}

- (void)resetView {
    [super resetView];
    
    self.operationView.hidden = NO;
    self.operationView.frame = self.coverImgView.bounds;
    [self.coverImgView addSubview:self.operationView];
    
}

#pragma mark - MTSortVideoOperationViewDelegate

- (void)videoOperationView:(MTSortVideoOperationView *)operationView didClickFullScreen:(MTVideoListModel *)model {
    
    if ([self.delegate respondsToSelector:@selector(sortVideoViewCell:didClickFullScreen:)]) {
        [self.delegate sortVideoViewCell:self didClickFullScreen:self.model];
    }

}

- (MTSortVideoOperationView *)operationView {
    if (!_operationView) {
        _operationView = [[MTSortVideoOperationView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _operationView.delegate = self;
    }
    return _operationView;
}

@end
