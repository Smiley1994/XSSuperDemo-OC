//
//  XSSplashViewController.m
//  XSSuperDemo-OC
//
//  Created by 晓松 on 2018/7/2.
//  Copyright © 2018年 GoodMorning. All rights reserved.
//

#import "XSSplashViewController.h"

@interface XSSplashViewController ()

@end

@implementation XSSplashViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    
}


@end
