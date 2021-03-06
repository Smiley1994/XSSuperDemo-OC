//
//  XSSplashViewController.m
//  XSSuperDemo-OC
//
//  Created by 晓松 on 2018/7/2.
//  Copyright © 2018年 GoodMorning. All rights reserved.
//

#import "XSSplashViewController.h"
#import "iQiYiPlayButton.h"
#import "YouKuPlayButton.h"
#import "XSUIMacro.h"
#import <MediaPlayer/MediaPlayer.h>
#import "XSRootViewController.h"
#import <objc/objc.h>

@interface XSSplashViewController () {
    
    iQiYiPlayButton *_iQiYiPlayButton;
    YouKuPlayButton *_youKuPlayButton;
}

@end

@implementation XSSplashViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    //创建播放按钮，需要初始化一个状态，即显示暂停还是播放状态
//    _iQiYiPlayButton = [[iQiYiPlayButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) state:iQiYiPlayButtonStatePlay];
//    _iQiYiPlayButton.center = CGPointMake(self.view.center.x, self.view.bounds.size.height/3);
//    [_iQiYiPlayButton addTarget:self action:@selector(iQiYiPlayMethod) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_iQiYiPlayButton];

    //创建播放按钮，需要初始化一个状态，即显示暂停还是播放状态
//    _youKuPlayButton = [[YouKuPlayButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) state:YouKuPlayButtonStatePlay];
//    _youKuPlayButton.center = CGPointMake(self.view.center.x, self.view.bounds.size.height*2/3);
//    [_youKuPlayButton addTarget:self action:@selector(youKuPlayMethod) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_youKuPlayButton];
    
    [self openRootViewController];
    
//    char a = 10;
//
//    printf("修改前，a的值：%d\n", a);
//
//    char *p = &a;
//
//    *p = 9;
//
//    printf("修改前，a的值：%d\n", a);
//
//    char value = *p;
//
//    printf("que a的值：%d", value);
    
//    char a= 10, b = 20;
    
//    printf("更换前：a = %d, b = %d\n", a, b);
//    swapA(10, 20);
//    swapB(&a, &b);
//    printf("更换后：a=%d, b=%d\n", a, b);
    
}

int sumAndMinus(int v1, int v2, int sum) {
    
    return v1 + v2;
}

void swapA(char v1,char v2) {
    printf("交换前：v1 = %d, v2 = %d \n",v1, v2);
    char temp;
    temp = v1;
    v1 = v2;
    v2 = temp;
    printf("交换后：v1 = %d, v2 = %d \n",v1, v2);
}

void swapB(char *v1, char *v2) {
    char temp;
    
    temp = *v1;
    
    *v1 = *v2;
    
    *v2 = temp;
}

- (void) openRootViewController {
    XSRootViewController *rootViewController = [[XSRootViewController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
}

- (void)iQiYiPlayMethod {
    //通过判断当前状态 切换显示状态
    if (_iQiYiPlayButton.buttonState == iQiYiPlayButtonStatePause) {
        _iQiYiPlayButton.buttonState = iQiYiPlayButtonStatePlay;
    }else {
        _iQiYiPlayButton.buttonState = iQiYiPlayButtonStatePause;
    }
}

- (void)youKuPlayMethod {
    //通过判断当前状态 切换显示状态
    if (_youKuPlayButton.buttonState == YouKuPlayButtonStatePause) {
        _youKuPlayButton.buttonState = YouKuPlayButtonStatePlay;
    }else {
        _youKuPlayButton.buttonState = YouKuPlayButtonStatePause;
    }
}


@end
