//
//  RoomToolboxUnfoldItemModel.h
//  RoomToolboxUnfoldItemModel
//
//  Created by Macrolor  on 2021/12/8.
//  Copyright © 2021 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoomToolboxUnfoldCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
