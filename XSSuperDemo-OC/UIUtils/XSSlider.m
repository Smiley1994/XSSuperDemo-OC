//
//  XSSlider.m
//  XSSuperDemo-OC
//
//  Created by 晓松 on 2018/12/3.
//  Copyright © 2018 GoodMorning. All rights reserved.
//

#import "XSSlider.h"
#import "XSUIMacro.h"

@implementation XSSlider


- (CGRect)trackRectForBounds:(CGRect)bounds {
    return CGRectMake(0, 0, SCREEN_WIDTH - WidthScale *175, 7);
}

@end
