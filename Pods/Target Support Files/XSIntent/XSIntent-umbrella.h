#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "IntentFace.h"
#import "NSObject+XSSwizzling.h"
#import "UIViewController+XSIntent.h"
#import "XSError.h"
#import "XSErrorCode.h"
#import "XSIntent.h"

FOUNDATION_EXPORT double XSIntentVersionNumber;
FOUNDATION_EXPORT const unsigned char XSIntentVersionString[];

