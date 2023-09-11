//
//  MTVideoViewCell.m
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/4.
//

#import "MTVideoViewCell.h"

@interface MTVideoViewCell()

@property (nonatomic, copy) IBInspectable NSString *reuseIdentifier;

@end


@implementation MTVideoViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:CGRectMake(0, 0, 320, 44)]) {
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}

- (void)prepareForReuse {
    
}

@end
