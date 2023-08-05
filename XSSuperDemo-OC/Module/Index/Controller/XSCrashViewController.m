//
//  XSCrashViewController.m
//  XSCrashViewController
//
//  Created by Macrolor  on 2021/9/27.
//  Copyright © 2021 GoodMorning. All rights reserved.
//

#import "XSCrashViewController.h"
#import <Masonry/Masonry.h>

@interface XSCrashViewController ()

@end

@implementation XSCrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self setupUI];
}


- (void)setupUI {
    
    UIButton *sentryCrashButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [sentryCrashButton setTitle:@"sentryCrash" forState:UIControlStateNormal];
    [sentryCrashButton addTarget:self action:@selector(sentryCrash) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sentryCrashButton];
    [sentryCrashButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(99);
    }];
    
    UIButton *crashButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [crashButton setTitle:@"返回上一页" forState:UIControlStateNormal];
    [crashButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:crashButton];
    [crashButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(sentryCrashButton.mas_bottom).offset(15);
    }];
}

- (void)back {
    self.sendValueBlock(@"aaaaaa");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sentryCrash {
//    [SentrySDK crash];
}

- (void)crash {
    NSArray *array = @[@"0",@"1",@"2",@"3"];
    [array objectAtIndex:6];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
