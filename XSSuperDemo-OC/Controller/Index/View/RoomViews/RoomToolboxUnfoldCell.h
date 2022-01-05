//
//  RoomToolboxUnfoldCell.h
//  RoomToolboxUnfoldCell
//
//  Created by Macrolor on 2021/12/8.
//  Copyright © 2021 GoodMorning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomToolboxUnfoldCellModel.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const RoomToolboxUnfoldCellIdentify = @"RoomToolboxUnfoldCellIdentify";

@interface RoomToolboxUnfoldCell : UICollectionViewCell

- (void)setupModel:(RoomToolboxUnfoldCellModel *)model;

@end

NS_ASSUME_NONNULL_END
