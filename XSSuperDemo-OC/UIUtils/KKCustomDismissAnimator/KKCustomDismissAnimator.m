//
//  KKCustomDismissAnimator.m
//  richers
//
//  Created by mt230824 on 2023/9/20.
//

#import "KKCustomDismissAnimator.h"

@implementation KKCustomDismissAnimator

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return self.interval; // 设置自定义过渡动画的持续时间
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.alpha = 0.0; // 使视图透明
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
