//
//  KKCustomDismissAnimator.h
//  richers
//
//  Created by mt230824 on 2023/9/20.
//

/// 控制莫态控制器消失时间

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKCustomDismissAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval interval;

@end

NS_ASSUME_NONNULL_END
