//
//  HFCategoryTitleCellModel.m
//  UI系列测试
//
//  Created by Macrolor on 2018/3/15.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryTitleCellModel.h"

@implementation HFCategoryTitleCellModel

- (void)setTitle:(NSString *)title {
    _title = title;

    [self updateNumberSizeWidthIfNeeded];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;

    [self updateNumberSizeWidthIfNeeded];
}

- (void)updateNumberSizeWidthIfNeeded {
    if (self.titleFont) {
        _titleHeight = [self.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleFont} context:nil].size.height;
    }
}

@end
