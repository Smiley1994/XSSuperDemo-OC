//
//  UIViewController+Intent.m
//  YiShop
//
//  Created by 孙晓松 on 2016/11/14.
//  Copyright © 2016年 秦皇岛商之翼网络科技有限公司. All rights reserved.
//

#import "UIViewController+Intent.h"
#import "NSObject+Swizzling.h"
#import "YSUErrorCode.h"
#import "YSUBusiness.h"
#import <objc/runtime.h>

NSInteger const RESULT_OK = 0;
NSInteger const RESULT_CANCELED = 1;
NSInteger const RESULT_QUICK_BUY = 2;

static void * KEY_INTNET = &KEY_INTNET;
static void * KEY_IS_CLOSED = &KEY_IS_CLOSED;

@implementation UIViewController(Intent)

- (YSUError *)openClass:(NSString *)className {
    YSUIntent*intent = [YSUIntent intentWithClassName:className];
    return [self openIntent:intent];
}

- (YSUError *)openIntent:(YSUIntent*)intent {
    return [self openIntent:intent withRequest:NO andRequestCode:0];
}

- (YSUError *)openIntent:(YSUIntent*)intent withRequestCode:(NSInteger)requestCode {
    return [self openIntent:intent withRequest:YES andRequestCode:requestCode];
}

- (YSUError *)openIntent:(YSUIntent*)intent withRequest:(BOOL)request andRequestCode:(NSInteger)requestCode {
    if (!intent) {
        return [[YSUError alloc]initWithCode:YSU_ERROR_CLASS_NOT_FOUND andReason:LOCALIZE(@"intentIsEmpty")];
    }
    
    if (!intent.className || intent.className.length == 0) {
        return [[YSUError alloc]initWithCode:YSU_ERROR_CLASS_NOT_FOUND andReason:LOCALIZE(@"classNameIsEmpty")];
    }
    
    Class class = NSClassFromString(intent.className);
    if (!class) {
        return [[YSUError alloc]initWithCode:YSU_ERROR_CLASS_NOT_FOUND andReason:LOCALIZE_FORMAT(@"formatClassNotFound",intent.className)];
    }
    
    UIViewController *controller = [[class alloc]init];
    if (!controller && [controller isKindOfClass:[UIViewController class]]) {
        return [[YSUError alloc]initWithCode:YSU_ERROR_CLASS_NOT_FOUND andReason:LOCALIZE_FORMAT(@"formatFailedToInitializeContrller",intent.className)];
    }
    
    [intent setIsRequest:request];
    [intent setRequestCode:requestCode];
    
    if (!intent.delegate) {
        [intent setDelegate:self];
    }
    
    if ([controller respondsToSelector:@selector(setIntent:)]) {
        [controller setIntent:intent];
    }
    
    return [self willOpenViewController:controller withIntent:intent];
}

- (void)cancel {
    [self finishWithResultCode:RESULT_CANCELED];
}

- (void)finish {
    [self cancel];
}

- (void)finishWithResultCode:(NSInteger)resultCode {
    [self finishWithResultCode:resultCode andResultData:nil];
}

- (void)finishWithResultCode:(NSInteger)resultCode andResultData:(NSDictionary *)resultData {
    id delegate = [[self getIntent] delegate];
    if (!delegate){
        [self closeCurrentViewController];
        return;
    }
    BOOL isRequest = [[self getIntent] isRequest];
    NSInteger requestCode = [[self getIntent] requestCode];
    
    if (delegate && [delegate respondsToSelector:@selector(willCloseViewController:withIntent:)]) {
        [delegate willCloseViewController:self withIntent:[self getIntent]];
    } else {
        [self closeCurrentViewController];
    }
    
    if (isRequest && delegate && [delegate respondsToSelector:@selector(onViewController:ofRequestCode:finshedWithResult:andResultData:)]){
        [delegate onViewController:self ofRequestCode:requestCode finshedWithResult:resultCode andResultData:resultData];
    }
}

#pragma mark - UIViewControllerIntentDelegate
- (YSUError *)willOpenViewController:(UIViewController *)controller withIntent:(YSUIntent *)intent {
    
    if (!controller) {
        return [YSUError errorWithCode:YSU_ERROR_NIL_VIEW_CONTROLLER andReason:LOCALIZE(@"viewControllerCannotBeNil")];
    }
    
    if (intent.method == OPEN_METHOD_PUSH){
        if(!self.navigationController){
            return [[YSUError alloc]initWithCode:YSU_ERROR_CLASS_NOT_FOUND andReason:LOCALIZE(@"navigationControllerIsEmpty")];
        }
        
        controller.hidesBottomBarWhenPushed = intent.hidesBottomBarWhenPushed;
        
        if (intent.useNavigationToPush) {
            UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:controller];
            [self.navigationController pushViewController:navigationController animated:intent.animated];
        } else {
            [self.navigationController pushViewController:controller animated:intent.animated];
        }
        return [YSUError ok];
        
    } else if (intent.method == OPEN_METHOD_POP) {
        if (intent.useNavigationToPush) {
            UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:controller];
            [self presentViewController:navigationController animated:YES completion:NULL];
            return [YSUError ok];
        }
        controller.definesPresentationContext = YES;
        controller.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:controller animated:intent.animated completion:NULL];
        return [YSUError ok];
        
    } else if (intent.method == OPEN_METHOD_SHOW) {
        controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:controller animated:intent.animated completion:NULL];
        return [YSUError ok];
    }
    return [YSUError unknown];
}

- (void)onViewController:(UIViewController *)viewController ofRequestCode:(NSInteger)requestCode finshedWithResult:(NSInteger)resultCode andResultData:(YSUIntent *)data{
    
}

- (void)willCloseViewController:(UIViewController*)viewController withIntent:(YSUIntent *)intent{
    
    if (viewController.navigationController &&
        viewController.navigationController.viewControllers.count > 1) {
        
        UINavigationController *navigationController = viewController.navigationController;
        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:navigationController.childViewControllers];
        
        if(![viewControllers.lastObject isEqual:viewController]){
            if([viewController respondsToSelector:@selector(setClosed:)]) {
                [viewController setClosed:YES];
            }
        }
        else{
            [navigationController popViewControllerAnimated:intent.animated];
        }
    } else if (viewController.presentingViewController) {
        [viewController dismissViewControllerAnimated:YES completion:NULL];
    }
}

#pragma mark - Close current view controller.
- (void)closeCurrentViewController {
    [self.view endEditing:YES];
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
        
    } else if (self.navigationController) {
        UINavigationController *navigationController = self.navigationController;
        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:navigationController.childViewControllers];
        if ([viewControllers indexOfObject:self] != (viewControllers.count - 1)) {
            if([self respondsToSelector:@selector(setClosed:)]) {
                [self setClosed:YES];
            }
        } else {
            [navigationController popViewControllerAnimated:YES];
        }
    }

}

#pragma mark - Getters and setters

- (void)setIntent:(YSUIntent *)intent {
    objc_setAssociatedObject(self, KEY_INTNET, intent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YSUIntent *)getIntent {
    return objc_getAssociatedObject(self, KEY_INTNET);
}

- (void)setClosed:(BOOL)closed {
    objc_setAssociatedObject(self, KEY_IS_CLOSED, @(closed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isClosed {
    return [objc_getAssociatedObject(self, KEY_IS_CLOSED) boolValue];
}

@end
