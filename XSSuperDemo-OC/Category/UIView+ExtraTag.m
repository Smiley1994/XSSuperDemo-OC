//
//  UIView+ExtraTag.m
//  YiShop
//
//  Created by 孙晓松 on 16/6/8.
//  Copyright © 2016年 秦皇岛商之翼网络科技有限公司. All rights reserved.
//

#import "UIView+ExtraTag.h"
#import <objc/runtime.h>

static void * KEY_VIEW_TYPE = &KEY_VIEW_TYPE;
static void * KEY_POSITION = &KEY_POSITION;
static void * KEY_SECTION = &KEY_SECTION;
static void * KEY_EXTRA_INFO = &KEY_EXTRA_INFO;

@implementation UIView (ExtraTag)

- (void)setViewTypeForTag:(NSInteger)viewType {
    objc_setAssociatedObject(self, KEY_VIEW_TYPE, [NSNumber numberWithInteger:viewType], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPositionForTag:(NSInteger)position {
    objc_setAssociatedObject(self, KEY_POSITION, [NSNumber numberWithInteger:position], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSectionForTag:(NSInteger)section {
    objc_setAssociatedObject(self, KEY_SECTION, [NSNumber numberWithInteger:section], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setExtraInfoForTag:(NSInteger)extraInfo {
    objc_setAssociatedObject(self, KEY_EXTRA_INFO, [NSNumber numberWithInteger:extraInfo], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)getViewTypeOfTag {
    return [objc_getAssociatedObject(self, KEY_VIEW_TYPE) integerValue];
}

- (NSInteger)getPositionOfTag {
    return [objc_getAssociatedObject(self, KEY_POSITION) integerValue];
}

- (NSInteger)getSectionOfTag {
    return [objc_getAssociatedObject(self, KEY_SECTION) integerValue];
}

- (NSInteger)getExtraInfoOfTag {
    return [objc_getAssociatedObject(self, KEY_EXTRA_INFO) integerValue];
}

@end
