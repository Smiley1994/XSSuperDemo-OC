//
//  SMLagMonitor.h
//  XSSuperDemo-OC
//
//  Created by GoodMorning on 2023/8/29.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMLagMonitor : NSObject

+ (instancetype)shareInstance;

- (void)beginMonitor;

@end

NS_ASSUME_NONNULL_END
