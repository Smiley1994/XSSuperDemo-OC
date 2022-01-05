//
//  XSUIUtils.h
//  XSUIUtils
//
//  Created by Macrolor on 2021/12/8.
//  Copyright © 2021 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSUIUtils : NSObject

+ (UIImage *)waterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed;

@end

NS_ASSUME_NONNULL_END
