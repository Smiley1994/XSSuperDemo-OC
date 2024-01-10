//
//  UIViewController+IIPSideDialog.m
//  huafangDemo
//
//  Created by Liguoan on 2022/3/31.
//

#import "UIViewController+IIPSideDialog.h"
#import <objc/runtime.h>

@implementation UIViewController (IIPSideDialog)

static int _IIPSideDialogControllerKey;

#pragma mark - Public methods

- (void)sideDialogPushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.sideDialogController pushViewController:viewController animated:animated];
}

- (nullable UIViewController *)sideDialogPopViewControllerAnimated:(BOOL)animated {
    return [self.sideDialogController popViewControllerAnimated:animated];
}

- (void)sideDialogContentSizeWillChange:(CGSize)finalSize animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion {
    [self.sideDialogController sideDialogContentSizeWillChange:finalSize animations:animations completion:completion];
}

- (void)sideDialogWillHide {
    
}

- (void)sideDialogDidHide {
    
}

- (void)sideDialogWillShow {
    
}

- (void)sideDialogDidShow {
    
}

#pragma mark - Setter / Getter

- (void)setSideDialogController:(IIPSideDialogController *)sideDialogController {
    objc_setAssociatedObject(self, &_IIPSideDialogControllerKey, sideDialogController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (IIPSideDialogController *)sideDialogController {
    return objc_getAssociatedObject(self, &_IIPSideDialogControllerKey);
}

@end
