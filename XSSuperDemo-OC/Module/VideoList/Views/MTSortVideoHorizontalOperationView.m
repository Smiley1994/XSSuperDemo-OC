//
//  MTSortVideoHorizontalOperationView.m
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/6.
//

#import "MTSortVideoHorizontalOperationView.h"

#import <Masonry/Masonry.h>

@interface MTSortVideoHorizontalOperationView ()

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) NSDate *lastDoubleTapTime;

@end

@implementation MTSortVideoHorizontalOperationView

@synthesize player = _player;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
}

-  (void)setModel:(MTVideoListModel *)model {
    _model = model;
    
    
}

#pragma mark - Public Method

- (void)willBeginDragging {
    self.backButton.alpha = 0.4;
}

- (void)didEndDragging {
    self.backButton.alpha = 1;
}

#pragma mark - ZFPlayerMediaControl

- (void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl {
    CGFloat diff = [NSDate date].timeIntervalSince1970 - self.lastDoubleTapTime.timeIntervalSince1970;
    if (diff < 0.6) {
        [self handleDoubleTapped:gestureControl.singleTap];
        self.lastDoubleTapTime = [NSDate date];
    }else {
        [self handleSingleTapped];
    }
}

- (void)gestureDoubleTapped:(ZFPlayerGestureControl *)gestureControl {
    [self handleDoubleTapped:gestureControl.doubleTap];
    self.lastDoubleTapTime = [NSDate date];
}

- (void)handleSingleTapped {
    id<ZFPlayerMediaPlayback> manager = self.player.currentPlayerManager;
    if (manager.isPlaying) {
        [manager pause];
        
    }else {
        [manager play];
    }
}

- (void)handleDoubleTapped:(UITapGestureRecognizer *)gesture {
    // ignore
}

- (void)fullscreenDidClick {
    
    if ([self.delegate respondsToSelector:@selector(videoOperationView:didClickFullScreen:)]) {
        [self.delegate videoOperationView:self didClickFullScreen:self.model];
    }
}

- (void)backButtonClick {
    
    [self.rotationManager rotate];
    
}

#pragma mark - Lazy

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setTitle:@"退出全屏" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _backButton.layer.masksToBounds = YES;
        [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
