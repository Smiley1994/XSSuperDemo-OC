//
//  XSRootViewController.m
//  XSSuperDemo-OC
//
//  Created by Good_Morning_ on 2018/7/2.
//  Copyright © 2018年 GoodMorning. All rights reserved.
//

#import "XSRootViewController.h"
#import "XSIndexViewController.h"
#import "XSUserViewController.h"

@interface XSRootViewController ()

@end

@implementation XSRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createControllers];
    
}


- (void)createControllers {
    
    XSIndexViewController *indexViewController = [[XSIndexViewController alloc] init];
    indexViewController.tabBarItem.image = [[UIImage imageNamed:@"tab_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    indexViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_home_index"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    indexViewController.tabBarItem.title = @" ";
    indexViewController.tabBarItem.tag = 0;
    [indexViewController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : [UIColor clearColor]} forState:UIControlStateHighlighted];
    
    UINavigationController *indexNavigationController = [[UINavigationController alloc] initWithRootViewController:indexViewController];
    
    XSUserViewController *userViewController = [[XSUserViewController alloc] init];
    userViewController.tabBarItem.image = [[UIImage imageNamed:@"tab_user_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    userViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_user_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    userViewController.tabBarItem.title = @"user";
    userViewController.tabBarItem.tag = 1;
    [userViewController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : [UIColor redColor                                                         ]} forState:UIControlStateHighlighted];
    
    UINavigationController *userNavigationController = [[UINavigationController alloc] initWithRootViewController:userViewController];
    

    self.viewControllers = [NSArray arrayWithObjects:indexNavigationController,userNavigationController, nil];
    
//    self.selectedIndex = 0;
    
}

- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    self.selectedIndex = item.tag;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    NSLog(@"%lu",(unsigned long)selectedIndex);
    if (selectedIndex == 0) {
        self.tabBar.items.firstObject.title = @" ";
        self.tabBar.items.firstObject.imageInsets = UIEdgeInsetsMake(5, 0, -6, 0);
    } else {
        self.tabBar.items.firstObject.title = @"index";
        self.tabBar.items.firstObject.imageInsets = UIEdgeInsetsZero;
    }
}



@end
