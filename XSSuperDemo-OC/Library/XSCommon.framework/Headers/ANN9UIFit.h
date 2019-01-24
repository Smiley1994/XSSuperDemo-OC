//
//  ANN9UIFit.h
//  BabyLearnEnglish
//
//  Created by 晓松 on 2019/1/21.
//  Copyright © 2019 ann9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ANN9UIFit : NSObject

+(CGFloat)percentageWithScreenWidth;

+(CGFloat)percentageWithScreenHeight;

+(CGFloat)fitWidth:(CGFloat)width;

+(CGFloat)fitHeight:(CGFloat)height;

+(CGFloat)fitLandscapeFont:(CGFloat)size;

+(CGFloat)fitVerticalScreenFont:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
