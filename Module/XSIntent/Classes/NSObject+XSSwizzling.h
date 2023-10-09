//
//  NSObject+XSSwizzling.h
//  XSIntent
//
//  Created by mt230824 on 2023/10/9.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (XSSwizzling)

+ (void)swizzlingMethod:(SEL)originalSelector toMethod:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
