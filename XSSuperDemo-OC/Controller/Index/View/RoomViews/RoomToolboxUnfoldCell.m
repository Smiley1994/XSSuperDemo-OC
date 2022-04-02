//
//  RoomToolboxUnfoldCell.m
//  RoomToolboxUnfoldCell
//
//  Created by Macrolor  on 2021/12/8.
//  Copyright © 2021 GoodMorning. All rights reserved.
//

#import "RoomToolboxUnfoldCell.h"


@interface RoomToolboxUnfoldCell ()

@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation RoomToolboxUnfoldCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.contentView.backgroundColor = [UIColor clearColor];
    
    CGFloat ImageWidth = 25;
    
    self.imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageWidth)];
    self.imgIcon.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.imgIcon];
    
    self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, ImageWidth + 2, ImageWidth, 11)];
    self.lblTitle.textColor = [UIColor whiteColor];
    self.lblTitle.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.lblTitle];
}

- (void)setupModel:(RoomToolboxUnfoldCellModel *)model {
    
    self.imgIcon.image = [UIImage imageNamed:model.imageName];
    self.lblTitle.text = model.title;
    
}

@end
