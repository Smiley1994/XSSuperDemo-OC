//
//  MTSortVideoPanGestureRecognizer.h
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MTPanGestureRecognizerDirection) {
    MTPanGestureRecognizerDirectionVertical,
    MTPanGestureRecognizerDirectionHorizontal
};

@interface MTSortVideoPanGestureRecognizer : UIPanGestureRecognizer

@property (nonatomic, assign) MTPanGestureRecognizerDirection direction;

@end

NS_ASSUME_NONNULL_END
