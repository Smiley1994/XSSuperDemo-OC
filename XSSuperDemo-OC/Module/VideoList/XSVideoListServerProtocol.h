//
//  XSVideoListServerProtocol.h
//  XSSuperDemo-OC
//
//  Created by mt230824 on 2023/9/11.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeeHive.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XSVideoListServerProtocol <NSObject, BHServiceProtocol>

- (void)setupParameter:(NSDictionary *)parameter;

@end

NS_ASSUME_NONNULL_END
