//
//  XSSplashServer.h
//  XSSuperDemo-OC
//
//  Created by GoodMorning on 2023/8/5.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeeHive.h"

@protocol XSSplashServerProtocol <NSObject, BHServiceProtocol>

- (void)setupParameter:(NSDictionary *)dic;

@end
