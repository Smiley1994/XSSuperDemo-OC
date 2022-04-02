//
//  XSTestViewController.m
//  XSTestViewController
//
//  Created by Macrolor  on 2021/12/2.
//  Copyright © 2021 GoodMorning. All rights reserved.
//

#import "XSTestViewController.h"
#import "XSUIUtils.h"
#import <Masonry/Masonry.h>

#import "RoomToolboxUnfoldView.h"
#import "HFPopView.h"

#import "YSUIntent.h"
#import "UIViewController+Intent.h"

@interface XSTestViewController ()

@end

@implementation XSTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

-(void)setupUI {
    
    
    UIButton *crashButton = [UIButton buttonWithType:UIButtonTypeSystem];
    crashButton.frame = CGRectMake(10, 100, 100, 50);
    [crashButton setTitle:@"click" forState:UIControlStateNormal];
    [crashButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:crashButton];
    
}

- (void)click {
    
    [self finishWithResultCode:RESULT_OK andResultData:@{@"aaa":@"111"}];
//    [self cancel];
}



- (void)testWaterImage {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    
    NSDictionary *attr = @{
        NSFontAttributeName: [UIFont boldSystemFontOfSize:21],  //设置字体
        NSForegroundColorAttributeName : [UIColor whiteColor]   //设置字体颜色
    };
    
    UIImage *image = [XSUIUtils waterImageWithImage:[UIImage imageNamed:@"bg"] text:@"我的邀请码 ：666666" textPoint:CGPointMake(169, 689.5) attributedString:attr];
    imageView.image = image;
//    imageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:imageView];
    
}

@end
