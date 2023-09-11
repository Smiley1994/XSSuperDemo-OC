//
//  MTSortVideoViewCell.m
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/5.
//

#import "MTSortVideoViewCell.h"

#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>

@interface MTSortVideoViewCell ()

@property (nonatomic, assign) BOOL isFullscreen;

@end

@implementation MTSortVideoViewCell

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
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.coverImgView.frame = self.bounds;
}

- (void)setupModel:(MTVideoListModel *)model {
    self.model = model;
    
    [self.coverImgView setImageWithURL:[NSURL URLWithString:model.poster_small] options:0];
    
}

- (void)resetView {
    
}

#pragma mark - Lazy
- (UIImageView *)coverImgView {
    if (!_coverImgView) {
        _coverImgView = [[UIImageView alloc] init];
        _coverImgView.contentMode = UIViewContentModeScaleAspectFit;
        _coverImgView.userInteractionEnabled = YES;
    }
    return _coverImgView;
}


@end
