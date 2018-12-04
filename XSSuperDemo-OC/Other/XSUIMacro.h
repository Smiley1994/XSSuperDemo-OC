//
//  XSUIMacro.h
//  XSSuperDemo-OC
//
//  Created by 晓松 on 2018/7/17.
//  Copyright © 2018年 GoodMorning. All rights reserved.
//

#ifndef XSUIMacro_h
#define XSUIMacro_h

#pragma mark - Screen size
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define WINDOW [[UIApplication sharedApplication] keyWindow]
#define SCALE_SIZE   ([UIScreen mainScreen].bounds.size.width / 375.0)//适配尺寸宏
#define NAVIGATION_HEIGHT 64.0

//适配机型比例
#define WidthScale (SCREEN_WIDTH / 375.0)
#define HeightScale (SCREEN_HEIGHT / 667.0)

#pragma mark - CGRect
#define RECT_X(f) f.origin.x
#define RECT_Y(f) f.origin.y
#define RECT_WIDTH(f) f.size.width
#define RECT_HEIGHT(f) f.size.height
#define RECT_SET_W(f, w) CGRectMake (RECT_X (f), RECT_Y (f), w, RECT_HEIGHT (f))
#define RECT_SET_H(f, h) CGRectMake (RECT_X (f), RECT_Y (f), RECT_WIDTH (f), h)
#define RECT_SET_X(f, x) CGRectMake (x, RECT_Y (f), RECT_WIDTH (f), RECT_HEIGHT (f))
#define RECT_SET_Y(f, y) CGRectMake (RECT_X (f), y, RECT_WIDTH (f), RECT_HEIGHT (f))
#define RECT_SET_SIZE(f, w, h) CGRectMake (RECT_X (f), RECT_Y (f), w, h)
#define RECT_SET_ORIGIN(f, x, y) CGRectMake (x, y, RECT_WIDTH (f), RECT_HEIGHT (f))

#pragma mark - View frame
#define WIDTH(view) view.frame.size.width
#define HEIGHT(view) view.frame.size.height
#define X(view) view.frame.origin.x
#define Y(view) view.frame.origin.y
#define LEFT(view) view.frame.origin.x
#define TOP(view) view.frame.origin.y
#define BOTTOM(view) (view.frame.origin.y + view.frame.size.height)
#define RIGHT(view) (view.frame.origin.x + view.frame.size.width)

#pragma mark - Color
#define RGB(r, g, b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
#define HEXCOLOR(c)                                  \
[UIColor colorWithRed:((c >> 16) & 0xFF) / 255.0 \
green:((c >> 8) & 0xFF) / 255.0  \
blue:(c & 0xFF) / 255.0         \
alpha:1.0]



#endif /* XSUIMacro_h */
