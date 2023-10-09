//
//  UIViewController+XSIntent.m
//  XSIntent
//
//  Created by mt230824 on 2023/10/9.
//

#import "UIViewController+XSIntent.h"
#import "NSObject+XSSwizzling.h"
#import "XSErrorCode.h"
#import <objc/runtime.h>

NSInteger const RESULT_OK = 0;
NSInteger const RESULT_CANCELED = 1;

static void * KEY_INTNET = &KEY_INTNET;
static void * KEY_IS_CLOSED = &KEY_IS_CLOSED;

@implementation UIViewController (XSIntent)

- (XSError *)openClass:(NSString *)className {
    XSIntent *intent = [XSIntent intentWithClassName:className];
    return [self openIntent:intent];
}

- (XSError *)openIntent:(XSIntent *)intent {
    return [self openIntent:intent withRequest:NO andRequestCode:0];
}

- (XSError *)openIntent:(XSIntent *)intent withRequestCode:(NSInteger)requestCode {
    return [self openIntent:intent withRequest:YES andRequestCode:requestCode];
}

- (XSError *)openIntent:(XSIntent *)intent withRequest:(BOOL)request andRequestCode:(NSInteger)requestCode {
    if (!intent) {
        return [[XSError alloc]initWithCode:XS_ERROR_CLASS_NOT_FOUND andReason:@"intent is nil"];
    }
    
    if (!intent.className || intent.className.length == 0) {
        return [[XSError alloc]initWithCode:XS_ERROR_CLASS_NOT_FOUND andReason:@"class name is nil"];
    }
    
    Class class = NSClassFromString(intent.className);
    if (!class) {
        return [[XSError alloc]initWithCode:XS_ERROR_CLASS_NOT_FOUND andReason:[NSString stringWithFormat:@"%@ Class Not Found", intent.className]];
    }
    
    UIViewController *controller = [[class alloc]init];
    if (!controller && [controller isKindOfClass:[UIViewController class]]) {
        return [[XSError alloc]initWithCode:XS_ERROR_CLASS_NOT_FOUND andReason:[NSString stringWithFormat:@"%@ Failed Initialize Contrller", intent.className]];
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
    id delegate = [[self intent] delegate];
    if (!delegate){
        [self closeCurrentViewController];
        return;
    }
    BOOL isRequest = [[self intent] isRequest];
    NSInteger requestCode = [[self intent] requestCode];
    
    if (delegate && [delegate respondsToSelector:@selector(willCloseViewController:withIntent:)]) {
        [delegate willCloseViewController:self withIntent:[self intent]];
    } else {
        [self closeCurrentViewController];
    }
    
    if (isRequest && delegate && [delegate respondsToSelector:@selector(onViewController:ofRequestCode:finshedWithResult:andResultData:)]){
        [delegate onViewController:self ofRequestCode:requestCode finshedWithResult:resultCode andResultData:resultData];
    }
}

#pragma mark - UIViewControllerIntentDelegate

- (XSError *)willOpenViewController:(UIViewController *)controller withIntent:(XSIntent *)intent {
    
    if (!controller) {
        return [XSError errorWithCode:XS_ERROR_NIL_VIEW_CONTROLLER andReason:@"ViewController Cannot Be Nil"];
    }
    
    if (intent.method == OPEN_METHOD_PUSH){
        if(!self.navigationController){
            return [[XSError alloc]initWithCode:XS_ERROR_CLASS_NOT_FOUND andReason:@"NavigationController Is Empty"];
        }
        
        controller.hidesBottomBarWhenPushed = intent.hidesBottomBarWhenPushed;
        
        if (intent.useNavigationToPush) {
            UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:controller];
            [self.navigationController pushViewController:navigationController animated:intent.animated];
        } else {
            [self.navigationController pushViewController:controller animated:intent.animated];
        }
        return [XSError ok];
        
    } else if (intent.method == OPEN_METHOD_POP) {
        if (intent.useNavigationToPush) {
            UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:controller];
            [self presentViewController:navigationController animated:YES completion:NULL];
            return [XSError ok];
        }
        controller.definesPresentationContext = YES;
        controller.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:controller animated:intent.animated completion:NULL];
        return [XSError ok];
        
    } else if (intent.method == OPEN_METHOD_SHOW) {
        controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:controller animated:intent.animated completion:NULL];
        return [XSError ok];
    }
    return [XSError unknown];
}

- (void)onViewController:(UIViewController *)viewController ofRequestCode:(NSInteger)requestCode finshedWithResult:(NSInteger)resultCode andResultData:(XSIntent *)data{
    
}

- (void)willCloseViewController:(UIViewController*)viewController withIntent:(XSIntent *)intent{
    
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


#pragma mark - Close current view controller

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

- (void)setIntent:(XSIntent *)intent {
    objc_setAssociatedObject(self, KEY_INTNET, intent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XSIntent *)intent {
    return objc_getAssociatedObject(self, KEY_INTNET);
}

- (void)setClosed:(BOOL)closed {
    objc_setAssociatedObject(self, KEY_IS_CLOSED, @(closed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isClosed {
    return [objc_getAssociatedObject(self, KEY_IS_CLOSED) boolValue];
}

@end
