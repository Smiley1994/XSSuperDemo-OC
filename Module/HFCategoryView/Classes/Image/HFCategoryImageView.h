//
//  HFCategoryImageView.h
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/20.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryIndicatorView.h"
#import "HFCategoryImageCell.h"
#import "HFCategoryImageCellModel.h"

@interface HFCategoryImageView : HFCategoryIndicatorView

@property (nonatomic, strong) NSArray <NSString *>*imageNames;

@property (nonatomic, strong) NSArray <NSURL *>*imageURLs;

@property (nonatomic, strong) NSArray <NSString *>*selectedImageNames;

@property (nonatomic, strong) NSArray <NSURL *>*selectedImageURLs;

@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);   //使用imageURL从远端下载图片进行加载，建议使用SDWebImage等第三方库进行下载。

@property (nonatomic, assign) CGSize imageSize;     //默认值为 CGSizeMake(20, 20)

@property (nonatomic, assign) CGFloat imageCornerRadius; //图片圆角

@property (nonatomic, assign, getter=isImageZoomEnabled) BOOL imageZoomEnabled;     //默认值为 NO

@property (nonatomic, assign) CGFloat imageZoomScale;    //默认值为 1.2，imageZoomEnabled 为 YES 时才生效

@end
