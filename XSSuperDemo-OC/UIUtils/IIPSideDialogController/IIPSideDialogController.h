//
//  IIPSideDialogController.h
//  huafangDemo
//
//  Created by Liguoan on 2022/3/31.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EnumIIPSideDialogDirection) {
    EnumIIPSideDialogDirectionNone,  // 没有方向 没有动画 直接显示。 用于 IIPFloatCardController。  注意：IIPSideDialogController 若方向为 EnumIIPSideDialogDirectionNone 则默认走 EnumIIPSideDialogDirectionFromBottom 逻辑。
    EnumIIPSideDialogDirectionFromTop,
    EnumIIPSideDialogDirectionFromLeft,
    EnumIIPSideDialogDirectionFromBottom,
    EnumIIPSideDialogDirectionFromRight,
};

@class IIPSideDialogNavigationController, IIPSideDialogController;

NS_ASSUME_NONNULL_BEGIN

@protocol IIPSideDialogDismissProtocol <NSObject>

- (BOOL)iipSideDialogControllerWhetherCanDismiss:(__kindof IIPSideDialogController *)sideDialogController;

@end

// Each notification includes a nil object and a userInfo dictionary containing the
// begining and ending frame.
// Animation key/value pairs are only available for the "will" family of notification.
extern NSString *IIPSideDialogControllerWillShowNotification;
extern NSString *IIPSideDialogControllerDidShowNotification;
extern NSString *IIPSideDialogControllerWillHideNotification;
extern NSString *IIPSideDialogControllerDidHideNotification;

extern NSString *IIPSideDialogControllerFrameBeginUserInfoKey;          // NSValue of CGRect
extern NSString *IIPSideDialogControllerFrameEndUserInfoKey;            // NSValue of CGRect
extern NSString *IIPSideDialogControllerAnimationDurationUserInfoKey;   // NSNumber of double
extern NSString *IIPSideDialogControllerCurveUserInfoKey;               // NSNumber of NSUInteger  (UIViewAnimationCurve)

extern NSString *IIPSideDialogControllerWillChangeSizeNotification;
extern NSString *IIPSideDialogControllerDidChangeSizeNotification;

/// Side dialog controller 消后的回调
typedef void(^IIPSideDialogControllerDidDismiss)(IIPSideDialogController *controller);

@interface IIPSideDialogController : UIViewController

#pragma mark - Contructor

/// 构造方法 Note: 构造 Side dialog
+ (instancetype)sideDialogController;

/// 构造方法 Note: 构造 Float card
+ (instancetype)floatCardController;

#pragma mark - Abount property

/// 是否为 Float card
/// Note: Float card 将出现在屏幕中间.
/// Note: Side dialog 将从屏幕边缘出现
@property (nonatomic, assign, getter=isFloatCard, readonly) BOOL floatCard;

/// 用于 Side dialog controller push view controller 时, 使用的导航控制器.  Note: show 方法中, 控制该导航控制器是否创建, 默认为 nil
@property (nonatomic, strong) IIPSideDialogNavigationController *iip_navigationController;

/// 属于 Side dialog controller 的唯一标识符  Note: 默认为 nil
@property (nonatomic, copy) NSString *iip_identifier;

/// 是否需要黑色背景遮罩.  Note: 默认为 No
@property (nonatomic, assign) BOOL needBlackMaskBackground;

/// 是否需要阻止掉背景点击后关闭的事件  Note: 默认为 No
@property (nonatomic, assign) BOOL needBlockBackgroundCloseAction;

/// Side dialog 出现的方向
@property (nonatomic, assign, readonly) EnumIIPSideDialogDirection direction;

/// 子视图控制器背景颜色.
@property (nonatomic, strong) UIColor *contentBackgroundColor;

/// 圆角, 支持四个方向任意选择
/// 默认:UIRectCornerAllCorners
/// Note: cornerRadius参数为设置, 则本参数设置无效
/// Note: 如果视图需要修改大小, 则需要自行设置圆角, 不可用 Side dialog controller 提供的设置圆角的方法
/// Note: 需要在 show 方法之前设置, 若需要在 show 方法之后设置圆角, 请使用 -sideDialogControllerSetupCornerDirection:cornerRadius:
@property (nonatomic, assign) UIRectCorner corner;

/// 圆角大小
/// Note: 如果视图需要修改大小, 则需要自行设置圆角, 不可用 Side dialog controller 提供的设置圆角的方法
/// Note: 需要在 show 方法之前设置, 若需要在 show 方法之后设置圆角, 请使用 -sideDialogControllerSetupCornerDirection:cornerRadius:
@property (nonatomic, assign) CGFloat cornerRadius;

/// 操作动画之类的, 都使用该视图控制器
@property (nonatomic, strong) __kindof UIViewController *contentViewController;
@property (nonatomic, assign) CGRect finalFrame;
@property (nonatomic, assign) CGRect originFrame;


#pragma mark - About show or hide side dialog or float card controller

/// 展示 Side dialog controller
/// @param subViewController Side dialog controller 中 需要显示的视图控制器
/// @param direction 展示方向
/// Note: 默认弹到
- (void)showSubViewController:(__kindof UIViewController *)subViewController direction:(EnumIIPSideDialogDirection)direction;

/// 展示 Side dialog controller
/// Note: 默认不创建 Navigation controller, 只能显示单一视图, 无法进行 Push 操作
/// @param superViewController Side dialog controller 的 父视图控制器
/// @param subViewController Side dialog controller 中 需要显示的视图控制器
/// @param direction 展示方向
- (void)showInViewController:(__kindof UIViewController *)superViewController subViewController:(__kindof UIViewController *)subViewController direction:(EnumIIPSideDialogDirection)direction;


/// 展示 Side dialog controller
/// @param superViewController Side dialog controller 的 父视图控制器
/// @param subViewController Side dialog controller 中 需要显示的视图控制器
/// @param direction 展示方向
/// @param inNavigationController 是否创建导航控制器
- (void)showInViewController:(__kindof UIViewController *)superViewController subViewController:(__kindof UIViewController *)subViewController direction:(EnumIIPSideDialogDirection)direction inNavigationController:(BOOL)inNavigationController;

/// 关闭 Side dialog controller
- (void)dismiss; // 默认带动画
- (void)dismissWithCompletionHandler:(IIPSideDialogControllerDidDismiss)completionHandler; // 默认带动画
- (void)dismissWithAnimation:(BOOL)animation;
- (void)dismissWithAnimation:(BOOL)animation completionHandler:(IIPSideDialogControllerDidDismiss)completionHandler;

#pragma mark - About navigation

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated;

#pragma mark - Abount  UI

/// Side dialog 子视图大小发生变化时, 通知 Side dialog 修改大小
- (void)sideDialogContentSizeWillChange:(CGSize)finalSize animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;

/// 设置圆角相关参数.
/// Note: 如果视图需要修改大小, 则需要自行设置圆角, 不可用 Side dialog controller 提供的设置圆角的方法
- (void)sideDialogControllerSetupCornerDirection:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius;

#pragma mark - About actions

- (void)actionClose:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
