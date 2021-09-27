//
//  UIView+Action.m
//  YiShop
//
//  Created by 孙晓松 on 2016/11/12.
//  Copyright © 2016年 秦皇岛商之翼网络科技有限公司. All rights reserved.
//

#import "UIView+Action.h"
#import "UIView+ExtraTag.h"
#import <objc/runtime.h>

static void * KEY_ITEM_TARGET = &KEY_ITEM_TARGET;
static void * KEY_ITEM_ACTION = &KEY_ITEM_ACTION;
static void * KEY_ITEM_POSITION = &KEY_ITEM_POSITION;
static void * KEY_ITEM_SECTION = &KEY_ITEM_SECTION;

@implementation UIView(Action)

- (SEL)itemAction {
    return NSSelectorFromString(objc_getAssociatedObject(self, KEY_ITEM_ACTION));
}

- (id)itemTarget {
    return objc_getAssociatedObject(self, KEY_ITEM_TARGET);
}

- (NSInteger)itemPosition {
    return [objc_getAssociatedObject(self, KEY_ITEM_POSITION) integerValue];
}

- (NSInteger)itemSection {
    return [objc_getAssociatedObject(self, KEY_ITEM_SECTION) integerValue];
}

- (void)addTarget:(id _Nonnull)target
           action:(SEL _Nonnull)action
          section:(NSInteger)section{
    [self addTarget:target action:action position:0 section:section];
}

- (void)addTarget:(id _Nonnull)target
           action:(SEL _Nonnull)action
         position:(NSInteger)position
          section:(NSInteger)section {
    objc_setAssociatedObject(self, KEY_ITEM_TARGET, target, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, KEY_ITEM_ACTION, NSStringFromSelector(action), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, KEY_ITEM_POSITION, @(position), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, KEY_ITEM_SECTION, @(section), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)onButtonClicked:(UIView *)sender {
    [self callTarget:sender];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self callTarget:textField];
}

- (void)onTap:(UIGestureRecognizer *)gesture {
    [self callTarget:gesture.view];
}

- (void)callTarget:(UIView *)sender {
    if (![self.itemTarget respondsToSelector:self.itemAction]) {
        return;
    }
    [sender setPositionForTag:self.itemPosition];
    [sender setSectionForTag:self.itemSection];
    IMP imp = [self.itemTarget methodForSelector:self.itemAction];
    void (*function) (id, SEL, UIView *) = (void *)imp;
    function (self.itemTarget, self.itemAction, sender);
}

- (void)addEvent:(UIView *)view {
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton*)view;
        [button addTarget:self
                   action:@selector (onButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
    } else if ([view isKindOfClass:[UITextField class]]) {
        UITextField *textFiled = (UITextField *)view;
        [textFiled addTarget:self
                      action:@selector (textFieldDidEndEditing:)
            forControlEvents:UIControlEventEditingDidEnd];
    } else if ([view isKindOfClass:[UIView class]]) {
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (onTap:)];
        [view.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [view removeGestureRecognizer:obj];
        }];
        [view addGestureRecognizer:gesture];
    }
}
@end
