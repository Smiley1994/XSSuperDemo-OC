//
//  IIPSideDialogNavigationController.h
//  huafangDemo
//
//  Created by Liguoan on 2022/4/8.
//

#import <UIKit/UIKit.h>

@class IIPSideDialogController;

NS_ASSUME_NONNULL_BEGIN

@interface IIPSideDialogNavigationController : UINavigationController

@property (nonatomic, weak) __kindof UIViewController *iip_rootViewController;

/// Constructor
+ (instancetype)navigationControllerWithRootViewController:(__kindof UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
