//
//  XSIndexModel.h
//  XSSuperDemo-OC
//
//  Created by 晓松 on 2018/11/14.
//  Copyright © 2018 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSInteger const MEDIA_CELL = 0;
static NSInteger const OTHER_CELL = 1;

@interface XSIndexModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
