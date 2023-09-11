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

#import "BeeHive.h"

#import "XSSplashServerProtocol.h"

@interface XSSplashViewController () <XSSplashServerProtocol>{
    
    iQiYiPlayButton *_iQiYiPlayButton;
    YouKuPlayButton *_youKuPlayButton;
}

@end

@BeeHiveService(XSSplashServerProtocol,XSSplashViewController)
@implementation XSSplashViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    auto int age = 10;
    static int height = 20;
    void (^block)(void) = ^{
        NSLog(@"age is %d, height is %d",age,height);
    };
    age = 20;
    height = 30;
    
    block();
    
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
    
}

- (void)setupParameter:(NSDictionary *)dic {
    
}


- (void)openRootViewController {
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
