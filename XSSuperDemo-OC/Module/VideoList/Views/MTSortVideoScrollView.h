//
//  MTSortVideoScrollView.h
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/4.
//

#import "MTVideoScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@class MTSortVideoScrollView;

@protocol MTSortVideoScrollViewDelegate <NSObject, MTVideoScrollViewDelegate>

@optional

- (void)scrollView:(MTSortVideoScrollView *)scrollView didPanWithDistance:(CGFloat)distance isEnd:(BOOL)isEnd;

@end



@interface MTSortVideoScrollView : MTVideoScrollView

@property (nonatomic, weak) id<MTSortVideoScrollViewDelegate> delegate;

- (void)addPanGesture;

@end

NS_ASSUME_NONNULL_END
