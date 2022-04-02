//
//  UIViewController+Intent.h
//  YiShop
//
//  Created by 孙晓松 on 2016/11/14.
//  Copyright © 2016年 秦皇岛商之翼网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YSUIntent.h"
#import "YSUError.h"

FOUNDATION_EXTERN NSInteger const RESULT_OK;
FOUNDATION_EXTERN NSInteger const RESULT_CANCELED;
FOUNDATION_EXTERN NSInteger const RESULT_QUICK_BUY;

@interface UIViewController(Intent)<UIViewControllerIntentDelegate>

- (YSUError *)openClass:(NSString *)className;
- (YSUError *)openIntent:(YSUIntent *)intent;
- (YSUError *)openIntent:(YSUIntent *)intent withRequestCode:(NSInteger)requestCode;
- (void)cancel;
- (void)finish;
- (void)finishWithResultCode:(NSInteger)resultCode;
- (void)finishWithResultCode:(NSInteger)resultCode andResultData:(NSDictionary *)resultData;
- (void)setIntent:(YSUIntent *)intent;
- (YSUIntent *)getIntent;
- (void)setClosed:(BOOL)closed;
- (BOOL)isClosed;

@end
