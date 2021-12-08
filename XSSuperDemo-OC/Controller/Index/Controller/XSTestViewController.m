//
//  XSTestViewController.m
//  XSTestViewController
//
//  Created by Macrolor on 2021/12/2.
//  Copyright © 2021 GoodMorning. All rights reserved.
//

#import "XSTestViewController.h"

@interface XSTestViewController ()

@end

@implementation XSTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

-(void)setupUI {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    
    NSDictionary *attr = @{
        NSFontAttributeName: [UIFont boldSystemFontOfSize:21],  //设置字体
        NSForegroundColorAttributeName : [UIColor whiteColor]   //设置字体颜色
    };
    
    UIImage *image = [self waterImageWithImage:[UIImage imageNamed:@"bg"] text:@"我的邀请码 ：666666" textPoint:CGPointMake(169, 689.5) attributedString:attr];
    imageView.image = image;
//    imageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:imageView];
}

// 给图片添加文字水印：
- (UIImage *)waterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed{
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印文字
    [text drawAtPoint:point withAttributes:attributed];
    //3.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}

// 给图片添加图片水印
+ (UIImage *)waterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect{
    
    //1.获取图片
    
    //2.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //3.绘制背景图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //绘制水印图片到当前上下文
    [waterImage drawInRect:rect];
    //4.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
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
