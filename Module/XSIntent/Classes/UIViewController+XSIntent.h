//
//  UIViewController+XSIntent.h
//  XSIntent
//
//  Created by mt230824 on 2023/10/9.
//

#import <UIKit/UIKit.h>

#import "XSIntent.h"
#import "XSError.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSInteger const RESULT_OK;
FOUNDATION_EXTERN NSInteger const RESULT_CANCELED;
FOUNDATION_EXTERN NSInteger const RESULT_QUICK_BUY;

@interface UIViewController (XSIntent) <UIViewControllerIntentDelegate>

- (XSError *)openClass:(NSString *)className;

- (XSError *)openIntent:(XSIntent *)intent;

- (XSError *)openIntent:(XSIntent *)intent withRequestCode:(NSInteger)requestCode;

- (void)cancel;

- (void)finish;

- (void)finishWithResultCode:(NSInteger)resultCode;

- (void)finishWithResultCode:(NSInteger)resultCode andResultData:(NSDictionary *)resultData;

- (void)setIntent:(XSIntent *)intent;
- (XSIntent *)intent;

- (void)setClosed:(BOOL)closed;
- (BOOL)isClosed;

@end

NS_ASSUME_NONNULL_END
