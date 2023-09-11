//
//  MTSortVideoScrollView.m
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/4.
//

#import "MTSortVideoScrollView.h"
#import "MTSortVideoPanGestureRecognizer.h"

@interface MTSortVideoScrollView()<UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) MTSortVideoPanGestureRecognizer *panGesture;

// 开始移动时的位置
@property (nonatomic, assign) CGFloat startLocationY;

@property (nonatomic, weak) id<MTSortVideoScrollViewDelegate> userDelegate;

@end


@implementation MTSortVideoScrollView

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        if (CGRectEqualToRect(frame, CGRectZero)) {
            self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }
        self.contentSize = CGSizeMake(0, self.frame.size.height);
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.contentSize.height == 0) {
        self.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    }
}

- (void)addPanGesture {
    [self addGestureRecognizer:self.panGesture];
}

- (void)setDelegate:(id<MTSortVideoScrollViewDelegate>)delegate {
    [super setDelegate:delegate];
    
    if (delegate) {
        self.userDelegate = delegate;
    }else {
        self.userDelegate = nil;
    }
}

#pragma mark - Gesture
- (void)handlePanGesture:(MTSortVideoPanGestureRecognizer *)panGesture {
    if (self.currentIndex == 0) {
        CGPoint location = [panGesture locationInView:panGesture.view];
        
        switch (panGesture.state) {
            case UIGestureRecognizerStateBegan: {
                self.startLocationY = location.y;
            }
                break;
            case UIGestureRecognizerStateChanged: {
                if (panGesture.direction == MTPanGestureRecognizerDirectionVertical) {
                    // 这里取整是解决上滑时可能出现的distance > 0的情况
                    CGFloat distance = ceil(location.y) - ceil(self.startLocationY);
                    if (distance > 0) { // 只要distance>0且没松手 就认为是下滑
                        self.panGestureRecognizer.enabled = NO;
                    }
                    
                    if (self.panGestureRecognizer.enabled == NO) {
                        [self didPanWithDistance:distance isEnd:NO];
                    }
                }
            }
                break;
            case UIGestureRecognizerStateFailed:
            case UIGestureRecognizerStateCancelled:
            case UIGestureRecognizerStateEnded: {
                if (self.panGestureRecognizer.enabled == NO) {
                    CGFloat distance = location.y - self.startLocationY;
                    [self didPanWithDistance:distance isEnd:YES];
                    self.panGestureRecognizer.enabled = YES;
                }
            }
                break;
                
            default:
                break;
        }
        
        [panGesture setTranslation:CGPointZero inView:panGesture.view];
    }
}

// 允许多个手势响应
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (otherGestureRecognizer.view == self) {
        return YES;
    }
    return NO;
}

- (void)didPanWithDistance:(CGFloat)distance isEnd:(BOOL)isEnd {
    if ([self.userDelegate respondsToSelector:@selector(scrollView:didPanWithDistance:isEnd:)]) {
        [self.userDelegate scrollView:self didPanWithDistance:distance isEnd:isEnd];
    }
}

#pragma mark - Lazy
- (MTSortVideoPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[MTSortVideoPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        _panGesture.delegate = self;
        _panGesture.direction = MTPanGestureRecognizerDirectionVertical;
    }
    return _panGesture;
}

@end
