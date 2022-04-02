//
//  HFCategoryDotCellModel.h
//  HFCategoryView
//
//  Created by Macrolor on 2018/8/20.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryTitleCellModel.h"

typedef NS_ENUM(NSUInteger, HFCategoryDotRelativePosition) {
    HFCategoryDotRelativePosition_TopLeft = 0,
    HFCategoryDotRelativePosition_TopRight,
    HFCategoryDotRelativePosition_BottomLeft,
    HFCategoryDotRelativePosition_BottomRight,
};

@interface HFCategoryDotCellModel : HFCategoryTitleCellModel

@property (nonatomic, assign) BOOL dotHidden;
@property (nonatomic, assign) HFCategoryDotRelativePosition relativePosition;
@property (nonatomic, assign) CGSize dotSize;
@property (nonatomic, assign) CGFloat dotCornerRadius;
@property (nonatomic, strong) UIColor *dotColor;
@property (nonatomic, assign) CGPoint dotOffset;

@end
