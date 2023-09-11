//
//  MTSortVideoViewHorizontalCell.m
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/5.
//

#import "MTSortVideoViewHorizontalCell.h"

#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>

@interface MTSortVideoViewHorizontalCell ()

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation MTSortVideoViewHorizontalCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    [self addSubview:self.coverImgView];
    [self.coverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
//    [self addSubview:self.backButton];
//    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(25);
//        make.left.equalTo(self).offset(12);
//    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.coverImgView.frame = self.bounds;
    
}

- (void)setupModel:(MTVideoListModel *)model {
    self.model = model;
    
    [self.coverImgView setImageWithURL:[NSURL URLWithString:model.poster_small] options:0];
    
    if (self.weak_playerManager) {
        [self.weak_playerManager requestPlayUrlWithModel:model completion:nil];
    }
}

- (void)autoHideOperationView {
    
    
}

- (void)resetView {
    [super resetView];
    
    
}

- (void)backButtonClick {
    
    !self.backClickBlock ?: self.backClickBlock();
    
}


#pragma mark - Lazy

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setTitle:@"退出全屏" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
