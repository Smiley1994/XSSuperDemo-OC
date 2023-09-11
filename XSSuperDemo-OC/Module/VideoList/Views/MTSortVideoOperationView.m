//
//  MTSortVideoOperationView.m
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/5.
//

#import "MTSortVideoOperationView.h"

#import <Masonry/Masonry.h>

@interface MTSortVideoOperationView ()

@property (nonatomic, strong) UIButton *fullScreenButton;

@property (nonatomic, strong) NSDate *lastDoubleTapTime;

@end

@implementation MTSortVideoOperationView

@synthesize player = _player;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.fullScreenButton];
    [self.fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).inset(190);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
}

-  (void)setModel:(MTVideoListModel *)model {
    _model = model;
    
}

#pragma mark - Public Method

- (void)willBeginDragging {
    self.fullScreenButton.alpha = 0.4;
}

- (void)didEndDragging {
    self.fullScreenButton.alpha = 1;
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

#pragma mark - Lazy

- (UIButton *)fullScreenButton {
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setTitle:@"全屏播放" forState:UIControlStateNormal];
        [_fullScreenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_fullScreenButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _fullScreenButton.layer.masksToBounds = YES;
        _fullScreenButton.layer.cornerRadius = 15;
        _fullScreenButton.layer.borderWidth = 1;
        _fullScreenButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [_fullScreenButton addTarget:self action:@selector(fullscreenDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}

@end
