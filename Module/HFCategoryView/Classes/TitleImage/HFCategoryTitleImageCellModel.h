//
//  HFCategoryTitleImageCellModel.h
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/8.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryTitleCellModel.h"

typedef NS_ENUM(NSUInteger, HFCategoryTitleImageType) {
    HFCategoryTitleImageType_TopImage = 0,
    HFCategoryTitleImageType_LeftImage,
    HFCategoryTitleImageType_BottomImage,
    HFCategoryTitleImageType_RightImage,
    HFCategoryTitleImageType_OnlyImage,
    HFCategoryTitleImageType_OnlyTitle,
};

@interface HFCategoryTitleImageCellModel : HFCategoryTitleCellModel

@property (nonatomic, assign) HFCategoryTitleImageType imageType;

@property (nonatomic, strong) id imageInfo;
@property (nonatomic, strong) id selectedImageInfo;
@property (nonatomic, copy) void(^loadImageBlock)(UIImageView *imageView, id info);

@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);

@property (nonatomic, assign) CGSize imageSize;     //默认CGSizeMake(20, 20)

@property (nonatomic, assign) CGFloat titleImageSpacing;    //titleLabel和ImageView的间距，默认5

@property (nonatomic, assign, getter=isImageZoomEnabled) BOOL imageZoomEnabled;

@property (nonatomic, assign) CGFloat imageZoomScale;

@property (nonatomic, copy) NSString *imageName;    //加载bundle内的图片

@property (nonatomic, strong) NSURL *imageURL;      //图片URL

@property (nonatomic, copy) NSString *selectedImageName;

@property (nonatomic, strong) NSURL *selectedImageURL;

@end
