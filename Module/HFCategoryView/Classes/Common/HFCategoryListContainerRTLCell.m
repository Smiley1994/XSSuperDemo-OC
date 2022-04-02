//
//  HFCategoryListContainerRTLCell.m
//  HFCategoryView
//
//  Created by Macrolor on 2020/7/3.
//

#import "HFCategoryListContainerRTLCell.h"
#import "RTLManager.h"

@implementation HFCategoryListContainerRTLCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [RTLManager horizontalFlipViewIfNeeded:self];
        [RTLManager horizontalFlipViewIfNeeded:self.contentView];
    }
    return self;
}

@end
