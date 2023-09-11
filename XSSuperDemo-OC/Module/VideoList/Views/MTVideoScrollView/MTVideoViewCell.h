//
//  MTVideoViewCell.h
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTVideoViewCell : UIView

/// init method
- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier;

/// 唯一标识
@property (nonatomic, readonly, copy, nullable) NSString *reuseIdentifier;

/// 准备重用时调用
- (void)prepareForReuse NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
