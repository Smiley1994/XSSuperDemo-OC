//
//  HFCategoryNumberCellModel.h
//  DQGuess
//
//  Created by Macrolor on 2018/4/24.
//  Copyright © 2018年 Macrolor. All rights reserved.
//

#import "HFCategoryTitleCellModel.h"

@interface HFCategoryNumberCellModel : HFCategoryTitleCellModel

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *numberString;
@property (nonatomic, assign, readonly) CGFloat numberStringWidth;
@property (nonatomic, copy) void(^numberStringFormatterBlock)(NSInteger number);
@property (nonatomic, strong) UIColor *numberBackgroundColor;
@property (nonatomic, strong) UIColor *numberTitleColor;
@property (nonatomic, assign) CGFloat numberLabelWidthIncrement;
@property (nonatomic, assign) CGFloat numberLabelHeight;
@property (nonatomic, strong) UIFont *numberLabelFont;
@property (nonatomic, assign) CGPoint numberLabelOffset;
@property (nonatomic, assign) BOOL shouldMakeRoundWhenSingleNumber;

@end
