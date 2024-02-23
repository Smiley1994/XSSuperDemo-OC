//
//  IIPSideDialogController.m
//  huafangDemo
//
//  Created by Liguoan on 2022/3/31.
//

#import "IIPSideDialogController.h"
#import "UIViewController+IIPSideDialog.h"
#import "IIPSideDialogNavigationController.h"
#import "IIPFloatCardController.h"

static NSTimeInterval const kIIPSideDialogAnimationDuration = 0.2f;

NSString *IIPSideDialogControllerWillShowNotification = @"IIPSideDialogControllerWillShowNotification";
NSString *IIPSideDialogControllerDidShowNotification = @"IIPSideDialogControllerDidShowNotification";
NSString *IIPSideDialogControllerWillHideNotification = @"IIPSideDialogControllerWillHideNotification";
NSString *IIPSideDialogControllerDidHideNotification = @"IIPSideDialogControllerDidHideNotification";

NSString *IIPSideDialogControllerFrameBeginUserInfoKey = @"IIPSideDialogControllerFrameBeginUserInfoKey";
NSString *IIPSideDialogControllerFrameEndUserInfoKey = @"IIPSideDialogControllerFrameEndUserInfoKey";
NSString *IIPSideDialogControllerAnimationDurationUserInfoKey = @"IIPSideDialogControllerAnimationDurationUserInfoKey";
NSString *IIPSideDialogControllerCurveUserInfoKey = @"IIPSideDialogControllerCurveUserInfoKey";

NSString *IIPSideDialogControllerWillChangeSizeNotification = @"IIPSideDialogControllerWillChangeSizeNotification";
NSString *IIPSideDialogControllerDidChangeSizeNotification = @"IIPSideDialogControllerDidChangeSizeNotification";

@interface IIPSideDialogController ()

@property (nonatomic, weak) __kindof UIViewController *subViewController;
@property (nonatomic, strong) UIButton *backgroundButton;
@property (nonatomic, assign) BOOL animating;

@property (nonatomic, assign) EnumIIPSideDialogDirection direction;

@property (nonatomic, assign) BOOL floatCard;


@end

@implementation IIPSideDialogController

#pragma mark - Constructor

- (instancetype)init {
    
    if (self = [super init]) {
        
        // Setup vars
        [self setupVars];
    }
    
    return self;
}

+ (instancetype)sideDialogController {
    IIPSideDialogController *vc = [[IIPSideDialogController alloc] init];
    vc.floatCard = NO;
    return vc;
}

+ (instancetype)floatCardController {
    IIPFloatCardController *vc = [[IIPFloatCardController alloc] init];
    vc.floatCard = YES;
    return vc;
}

#pragma mark - Basic setup
- (void)setupVars {
    
    _corner = UIRectCornerAllCorners;
    _contentBackgroundColor = [UIColor whiteColor];
}

#pragma mark - Life cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup background button
    self.backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backgroundButton.frame = self.view.bounds;
    self.backgroundButton.alpha = 0.0f;
    [self.backgroundButton addTarget:self action:@selector(actionClose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backgroundButton];
    if (self.needBlackMaskBackground) {
        [self.backgroundButton setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.64f]];
    } else {
        [self.backgroundButton setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

#pragma mark - Action

- (void)actionClose:(UIButton *)sender {
    
    if (self.needBlockBackgroundCloseAction) {
        return;
    }
    
    if ([self.contentViewController conformsToProtocol:@protocol(IIPSideDialogDismissProtocol)]) {
        if ([self.contentViewController respondsToSelector:@selector(iipSideDialogControllerWhetherCanDismiss:)]) {
            BOOL canDismiss = [(id<IIPSideDialogDismissProtocol>)self.contentViewController iipSideDialogControllerWhetherCanDismiss:self];
            if (!canDismiss) {
                return;
            }
        }
    }
    
    [self dismissWithAnimation:YES];
}

#pragma mark - Public methods ---- About navigation

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (!self.iip_navigationController) {
        return;
    }
    
    [self.iip_navigationController pushViewController:viewController animated:animated];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    if (!self.iip_navigationController) {
        return nil;
    }
    
    return [self.iip_navigationController popViewControllerAnimated:animated];
}

#pragma mark - Public methods ---- About show or hide side dialog controller

- (void)showSubViewController:(__kindof UIViewController *)subViewController direction:(EnumIIPSideDialogDirection)direction {
    
//    UIViewController *superViewController = [iip_application topViewController];
//    if (!superViewController) {
//        return;
//    }
//    
//    [self showInViewController:superViewController subViewController:subViewController direction:direction];
}

- (void)showInViewController:(__kindof UIViewController *)superViewController subViewController:(__kindof UIViewController *)subViewController direction:(EnumIIPSideDialogDirection)direction {
    
    [self showInViewController:superViewController subViewController:subViewController direction:direction inNavigationController:NO];
}

- (void)showInViewController:(__kindof UIViewController *)superViewController subViewController:(__kindof UIViewController *)subViewController direction:(EnumIIPSideDialogDirection)direction inNavigationController:(BOOL)inNavigationController {
    
    // Setup super view controller
    [superViewController addChildViewController:self];
    [superViewController.view addSubview:self.view];
    [self didMoveToParentViewController:superViewController];
    
    // Setup navigation controller if needed
    if (inNavigationController) {
        self.iip_navigationController = [IIPSideDialogNavigationController navigationControllerWithRootViewController:subViewController];
        self.iip_navigationController.sideDialogController = self;
    }
    
    // Setup sub view controller
    _subViewController = subViewController;
    _subViewController.sideDialogController = self;
    _subViewController.view.backgroundColor = _contentBackgroundColor;
    [self addChildViewController:self.contentViewController];
    [self.view addSubview:self.contentViewController.view];
    [self.contentViewController didMoveToParentViewController:self];
    
    // Setup direction and frames
    self.direction = direction;
    [self setupOriginAndFinalFrame];
    
    // Setup corner radius
    if (_cornerRadius > 0 && self.contentViewController) {
        [self setupContentViewCornerRadius];
    }
    
    // Show
    [self showAnimationWithCompletion:^(BOOL finished) {}];
}

- (void)dismiss {
    [self dismissWithAnimation:YES completionHandler:^(IIPSideDialogController * _Nonnull controller) {}];
}

- (void)dismissWithCompletionHandler:(IIPSideDialogControllerDidDismiss)completionHandler {
    [self dismissWithAnimation:YES completionHandler:completionHandler];
}

- (void)dismissWithAnimation:(BOOL)animation {
    [self dismissWithAnimation:animation completionHandler:^(IIPSideDialogController * _Nonnull controller) {}];
}

- (void)dismissWithAnimation:(BOOL)animation completionHandler:(IIPSideDialogControllerDidDismiss)completionHandler {
    
    __weak typeof(self) weakSelf = self;
    [self hideAnimationWithCompletion:^(BOOL finished) {
        
        __strong typeof(self) strongSelf = weakSelf;
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        strongSelf.subViewController.sideDialogController = nil;
        strongSelf.iip_navigationController.sideDialogController = nil;
        
        for (UIViewController *subViewController in strongSelf.iip_navigationController.viewControllers) {
            if ([subViewController respondsToSelector:@selector(setSideDialogController:)]) {
                
                [subViewController setSideDialogController:nil];
            }
        }
        
        !completionHandler?:completionHandler(self);
        
    }];
}

#pragma mark - Public methods ---- About UI

- (void)sideDialogControllerSetupCornerDirection:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius {
    
    _corner = corner;
    _cornerRadius = cornerRadius;
    
    if (_cornerRadius <= 0) {
        return;
    }
    
    if (!self.contentViewController) {
        return;
    }
    
    [self setupContentViewCornerRadius];
}

- (void)setupContentViewCornerRadius {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentViewController.view.bounds
                                                   byRoundingCorners:_corner
                                                         cornerRadii:CGSizeMake(_cornerRadius,_cornerRadius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.contentViewController.view.bounds;
    maskLayer.path = maskPath.CGPath;
    self.contentViewController.view.layer.mask = maskLayer;
}

#pragma mark - About frame and size

- (void)setupOriginAndFinalFrame {
    
    CGSize viewSize = self.contentViewController.view.frame.size;
    switch (self.direction) {
            
        case EnumIIPSideDialogDirectionFromTop: {
            _originFrame = (CGRect){0, viewSize.height * -1, viewSize};
            _finalFrame = (CGRect){0, 0, viewSize};
            self.contentViewController.view.frame = _originFrame;
        }
            break;

        case EnumIIPSideDialogDirectionFromLeft: {
            _originFrame = (CGRect){viewSize.width * -1, 0, viewSize};
            _finalFrame = (CGRect){0, 0, viewSize};
            self.contentViewController.view.frame = _originFrame;
        }
            break;

        case EnumIIPSideDialogDirectionNone:
        case EnumIIPSideDialogDirectionFromBottom: {
            _originFrame = (CGRect){0, CGRectGetHeight(self.view.frame), viewSize};
            _finalFrame = (CGRect){0, CGRectGetHeight(self.view.frame) - viewSize.height, viewSize};
            self.contentViewController.view.frame = _originFrame;
        }
            break;

        case EnumIIPSideDialogDirectionFromRight: {
            _originFrame = (CGRect){CGRectGetWidth(self.view.frame), 0, viewSize};
            _finalFrame = (CGRect){CGRectGetWidth(self.view.frame) - viewSize.width, 0, viewSize};
            self.contentViewController.view.frame = _originFrame;
        }
            break;
    }
}

- (void)changeToFinalSize:(CGSize)finalSize {
    
    // Setup direction
    switch (self.direction) {
        case EnumIIPSideDialogDirectionFromTop: {
            
            CGFloat x = 0;
            CGFloat y = 0;
            CGSize size = finalSize;
            CGRect finalFrame = (CGRect){x, y, size};
            self.contentViewController.view.frame = finalFrame;
        }
            break;

        case EnumIIPSideDialogDirectionFromLeft: {
            
            CGFloat x = 0;
            CGFloat y = 0;
            CGSize size = finalSize;
            CGRect finalFrame = (CGRect){x, y, size};
            self.contentViewController.view.frame = finalFrame;
        }
            break;

        case EnumIIPSideDialogDirectionNone:
        case EnumIIPSideDialogDirectionFromBottom: {
            
            CGSize size = finalSize;
            CGFloat x = 0;
            CGFloat y = CGRectGetHeight(self.view.frame) - size.height;
            CGRect finalFrame = (CGRect){x, y, finalSize};
            self.contentViewController.view.frame = finalFrame;
            
        }
            break;

        case EnumIIPSideDialogDirectionFromRight: {
            
            CGSize size = finalSize;
            CGFloat x = CGRectGetWidth(self.view.frame) - size.width;
            CGFloat y = 0;
            CGRect finalFrame = (CGRect){x, y, finalSize};
            self.contentViewController.view.frame = finalFrame;
        }
            break;
    }
}


#pragma mark - Public methods ---- Notifications

- (void)sideDialogContentSizeWillChangeWithOriginFrame:(CGRect)originFrame
                                            finalFrame:(CGRect)finalFrame
                                              duration:(NSTimeInterval)duration
                                                 curve:(UIViewAnimationOptions)animationOption {
    
    // Setup params
    NSMutableDictionary *paramDictioanry = [NSMutableDictionary dictionary];
    
    CGRect rect = [self.view convertRect:originFrame
                                  toView:[UIApplication sharedApplication].keyWindow];
    NSValue *frameBegin = [NSValue valueWithCGRect:rect];
    if (frameBegin) {
        [paramDictioanry setObject:frameBegin forKey:IIPSideDialogControllerFrameBeginUserInfoKey];
    }
    
    rect = [self.view convertRect:finalFrame
                           toView:[UIApplication sharedApplication].keyWindow];
    NSValue *frameEnd = [NSValue valueWithCGRect:rect];
    if (frameEnd) {
        [paramDictioanry setObject:frameEnd forKey:IIPSideDialogControllerFrameEndUserInfoKey];
    }
    
    NSNumber *durationNumber = [NSNumber numberWithDouble:duration];
    if (durationNumber) {
        [paramDictioanry setObject:durationNumber forKey:IIPSideDialogControllerAnimationDurationUserInfoKey];
    }
    
    NSNumber *curve = [NSNumber numberWithInt:(int)animationOption];
    if (curve) {
        [paramDictioanry setObject:curve forKey:IIPSideDialogControllerCurveUserInfoKey];
    }
    
    // Post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:IIPSideDialogControllerWillChangeSizeNotification
                                                        object:self
                                                      userInfo:paramDictioanry];
}

- (void)sideDialogContentSizeDidChange {
    [self sideDialogContentSizeDidChangeWithFinalFrame:CGRectZero
                                              duration:0
                                                 curve:UIViewAnimationOptionCurveLinear];
}

- (void)sideDialogContentSizeDidChangeWithFinalFrame:(CGRect)finalFrame
                                            duration:(NSTimeInterval)duration
                                               curve:(UIViewAnimationOptions)animationOption {
    
    // Setup params
    NSMutableDictionary *paramDictioanry = [NSMutableDictionary dictionary];
    
    CGRect rect = [self.view convertRect:finalFrame
                                  toView:[UIApplication sharedApplication].keyWindow];
    NSValue *frameEnd = [NSValue valueWithCGRect:rect];
    if (frameEnd) {
        [paramDictioanry setObject:frameEnd forKey:IIPSideDialogControllerFrameEndUserInfoKey];
    }
    
    NSNumber *durationNumber = [NSNumber numberWithDouble:duration];
    if (durationNumber) {
        [paramDictioanry setObject:durationNumber forKey:IIPSideDialogControllerAnimationDurationUserInfoKey];
    }
    
    NSNumber *curve = [NSNumber numberWithInt:(int)animationOption];
    if (curve) {
        [paramDictioanry setObject:curve forKey:IIPSideDialogControllerCurveUserInfoKey];
    }
    
    // Post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:IIPSideDialogControllerDidChangeSizeNotification
                                                        object:self
                                                      userInfo:paramDictioanry];
}

- (void)sideDialogContentSizeWillChange:(CGSize)finalSize animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion {
    
    if (self.animating) {
        return;
    }
    self.animating = YES;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kIIPSideDialogAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear animations:^{
        
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf changeToFinalSize:finalSize];
        
        !animations?:animations();
        
    } completion:^(BOOL finished) {
        
        !completion?:completion(finished);
        self.animating = NO;
    }];
}

#pragma mark - Private methods ---- Notifications

- (void)postWillShowNotification {
    
    // Setup params
    NSMutableDictionary *paramDictioanry = [NSMutableDictionary dictionary];
    
    CGRect rect = [self.view convertRect:_subViewController.view.frame
                                  toView:[UIApplication sharedApplication].keyWindow];
    NSValue *frameBegin = [NSValue valueWithCGRect:rect];
    if (frameBegin) {
        [paramDictioanry setObject:frameBegin forKey:IIPSideDialogControllerFrameBeginUserInfoKey];
    }
    
    rect = [self.view convertRect:_finalFrame
                           toView:[UIApplication sharedApplication].keyWindow];
    NSValue *frameEnd = [NSValue valueWithCGRect:_finalFrame];
    if (frameEnd) {
        [paramDictioanry setObject:frameEnd forKey:IIPSideDialogControllerFrameEndUserInfoKey];
    }
    
    NSNumber *duration = [NSNumber numberWithDouble:kIIPSideDialogAnimationDuration];
    if (duration) {
        [paramDictioanry setObject:duration forKey:IIPSideDialogControllerAnimationDurationUserInfoKey];
    }
    
    NSNumber *curve = [NSNumber numberWithInt:UIViewAnimationOptionCurveEaseOut];
    if (curve) {
        [paramDictioanry setObject:curve forKey:IIPSideDialogControllerCurveUserInfoKey];
    }
    
    if ([_subViewController respondsToSelector:@selector(sideDialogWillShow)]) {
        [_subViewController sideDialogWillShow];
    }
    
    // Post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:IIPSideDialogControllerWillShowNotification
                                                        object:self
                                                      userInfo:paramDictioanry];
}

- (void)postDidShowNotification {
    
    // Setup params
    NSMutableDictionary *paramDictioanry = [NSMutableDictionary dictionary];
    
    CGRect rect = [self.view convertRect:_finalFrame
                                  toView:[UIApplication sharedApplication].keyWindow];
    NSValue *frameEnd = [NSValue valueWithCGRect:rect];
    if (frameEnd) {
        [paramDictioanry setObject:frameEnd forKey:IIPSideDialogControllerFrameEndUserInfoKey];
    }
    
    NSNumber *duration = [NSNumber numberWithDouble:kIIPSideDialogAnimationDuration];
    if (duration) {
        [paramDictioanry setObject:duration forKey:IIPSideDialogControllerAnimationDurationUserInfoKey];
    }
    
    NSNumber *curve = [NSNumber numberWithInt:UIViewAnimationOptionCurveEaseOut];
    if (curve) {
        [paramDictioanry setObject:curve forKey:IIPSideDialogControllerCurveUserInfoKey];
    }
    
    if ([_subViewController respondsToSelector:@selector(sideDialogDidShow)]) {
        [_subViewController sideDialogDidShow];
    }
    
    // Post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:IIPSideDialogControllerDidShowNotification
                                                        object:self
                                                      userInfo:paramDictioanry];
}

- (void)postWillHideNotification {
    
    // Setup params
    NSMutableDictionary *paramDictioanry = [NSMutableDictionary dictionary];
    
    CGRect rect = [self.view convertRect:_subViewController.view.frame
                                  toView:[UIApplication sharedApplication].keyWindow];
    NSValue *frameBegin = [NSValue valueWithCGRect:rect];
    if (frameBegin) {
        [paramDictioanry setObject:frameBegin forKey:IIPSideDialogControllerFrameBeginUserInfoKey];
    }
    
    rect = [self.view convertRect:_originFrame
                                  toView:[UIApplication sharedApplication].keyWindow];
    NSValue *frameEnd = [NSValue valueWithCGRect:rect];
    if (frameEnd) {
        [paramDictioanry setObject:frameEnd forKey:IIPSideDialogControllerFrameEndUserInfoKey];
    }
    
    NSNumber *duration = [NSNumber numberWithDouble:kIIPSideDialogAnimationDuration];
    if (duration) {
        [paramDictioanry setObject:duration forKey:IIPSideDialogControllerAnimationDurationUserInfoKey];
    }
    
    NSNumber *curve = [NSNumber numberWithInt:UIViewAnimationOptionCurveEaseIn];
    if (curve) {
        [paramDictioanry setObject:curve forKey:IIPSideDialogControllerCurveUserInfoKey];
    }
    
    if ([_subViewController respondsToSelector:@selector(sideDialogWillHide)]) {
        [_subViewController sideDialogWillHide];
    }
    
    // Post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:IIPSideDialogControllerWillHideNotification
                                                        object:self
                                                      userInfo:paramDictioanry];
}

- (void)postDidHideNotification {
    
    // Setup params
    NSMutableDictionary *paramDictioanry = [NSMutableDictionary dictionary];
    
    CGRect rect = [self.view convertRect:_originFrame
                                  toView:[UIApplication sharedApplication].keyWindow];
    NSValue *frameEnd = [NSValue valueWithCGRect:rect];
    if (frameEnd) {
        [paramDictioanry setObject:frameEnd forKey:IIPSideDialogControllerFrameEndUserInfoKey];
    }
    
    NSNumber *duration = [NSNumber numberWithDouble:kIIPSideDialogAnimationDuration];
    if (duration) {
        [paramDictioanry setObject:duration forKey:IIPSideDialogControllerAnimationDurationUserInfoKey];
    }
    
    NSNumber *curve = [NSNumber numberWithInt:UIViewAnimationOptionCurveEaseIn];
    if (curve) {
        [paramDictioanry setObject:curve forKey:IIPSideDialogControllerCurveUserInfoKey];
    }
    
    if ([_subViewController respondsToSelector:@selector(sideDialogDidHide)]) {
        [_subViewController sideDialogDidHide];
    }
    
    // Post notification
    [[NSNotificationCenter defaultCenter] postNotificationName:IIPSideDialogControllerDidHideNotification
                                                        object:self
                                                      userInfo:paramDictioanry];
}

#pragma mark - Private methods ---- Animation

- (void)showAnimationWithCompletion:(void (^ __nullable)(BOOL finished))completion {
    
    if (self.animating) {
        return;
    }
    self.animating = YES;
    
    // Post notification
    [self postWillShowNotification];
    
    // Begin animation
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kIIPSideDialogAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear animations:^{
        
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.contentViewController.view.frame = strongSelf.finalFrame;
        strongSelf.backgroundButton.alpha = 1.0f;
        
    } completion:^(BOOL finished) {
        
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.animating = NO;
        
        // Post notification and call back
        [self postDidShowNotification];
        !completion?:completion(finished);
        
    }];
}

- (void)hideAnimationWithCompletion:(void (^ __nullable)(BOOL finished))completion {
    
    if (self.animating) {
        return;
    }
    self.animating = YES;
    
    // Post notification
    [self postWillHideNotification];
    
    // Begin animation
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kIIPSideDialogAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear animations:^{
        
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.contentViewController.view.frame = strongSelf.originFrame;
        strongSelf.backgroundButton.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.animating = NO;
        
        // Post notification and call back
        [self postDidHideNotification];
        !completion?:completion(finished);
        
    }];
}

#pragma mark - Setter / Getter

- (__kindof UIViewController *)contentViewController {
    
    if (self.iip_navigationController) {
        
        return self.iip_navigationController;
    }
    
    return self.subViewController;
}

- (void)setNeedBlackMaskBackground:(BOOL)needBlackMaskBackground {
    
    _needBlackMaskBackground = needBlackMaskBackground;
    
    // Setup background button
    [self.backgroundButton setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.64f]];
}

- (void)setContentBackgroundColor:(UIColor *)contentBackgroundColor {
    
    _contentBackgroundColor = contentBackgroundColor;
    
    // Setup sub view controller's view background color
    if (self.subViewController) {
        self.subViewController.view.backgroundColor = _contentBackgroundColor;
    }
}

@end
