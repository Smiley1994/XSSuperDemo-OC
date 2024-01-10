//
//  IIPSideDialogNavigationController.m
//  huafangDemo
//
//  Created by Liguoan on 2022/4/8.
//

#import "IIPSideDialogNavigationController.h"

// Tools
#import "UIViewController+IIPSideDialog.h"

@interface IIPSideDialogNavigationController ()

@end

@implementation IIPSideDialogNavigationController

#pragma mark - Constructor

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    
    if (self = [super initWithRootViewController:rootViewController]) {
        
        self.iip_rootViewController = rootViewController;
        
        // Setup UI
        [self setupUI];
    }
    
    return self;
}

+ (instancetype)navigationControllerWithRootViewController:(__kindof UIViewController *)viewController {
    return [[self alloc] initWithRootViewController:viewController];
}

#pragma mark - Life cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup UI
    [self setupUI];
}

#pragma mark - Basic setup
- (void)setupUI {
    
    self.view.frame = self.iip_rootViewController.view.bounds;
    [self setNavigationBarHidden:YES];
}

#pragma mark - Override methods
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    
    viewController.sideDialogController = self.sideDialogController;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    UIViewController *viewController = [super popViewControllerAnimated:animated];
    viewController.sideDialogController = nil;
    return viewController;
}


@end
