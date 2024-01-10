//
//  UIViewController+IIPSideDialog.h
//  huafangDemo
//
//  Created by Liguoan on 2022/3/31.
//

#import <UIKit/UIKit.h>

// Controller
#import "IIPSideDialogController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (IIPSideDialog)

@property (nonatomic, weak) IIPSideDialogController *sideDialogController;

/// Side dialog 子视图大小发生变化时, 通知 Side dialog 修改大小
/// @param finalSize 最终变成的 Size
/// @param animations 子视图专属控件的动画在这个 block 中实现
/// @param completion 子视图专属操作在这个 block 中实现
- (void)sideDialogContentSizeWillChange:(CGSize)finalSize animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;

/// Side dialog 子视图需要 push view controller 时, 调用该方法
- (void)sideDialogPushViewController:(UIViewController *)viewController animated:(BOOL)animated;

/// Side dialog 子视图需要 pop view controller 时, 调用该方法
- (nullable UIViewController *)sideDialogPopViewControllerAnimated:(BOOL)animated;

- (void)sideDialogWillHide;
- (void)sideDialogDidHide;
- (void)sideDialogWillShow;
- (void)sideDialogDidShow;


@end

NS_ASSUME_NONNULL_END
