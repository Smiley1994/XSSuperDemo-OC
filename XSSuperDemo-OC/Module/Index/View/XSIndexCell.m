//
//  XSIndexCell.m
//  XSSuperDemo-OC
//
//  Created by 晓松 on 2018/11/14.
//  Copyright © 2018 GoodMorning. All rights reserved.
//

#import "XSIndexCell.h"

@implementation XSIndexCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubView];
    }
    return self;
}

- (void) createSubView {
    self.contentView.backgroundColor = UIColor.whiteColor;
    
    
    
}


@end
