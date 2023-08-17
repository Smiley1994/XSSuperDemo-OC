//
//  XSSplashModule.m
//  XSSuperDemo-OC
//
//  Created by GoodMorning on 2023/8/5.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import "XSSplashModule.h"

#import "BeeHive.h"

@interface XSSplashModule () <BHModuleProtocol>

@end

@BeeHiveMod(XSSplashModule)
@implementation XSSplashModule

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
}

- (void)modSetUp:(BHContext *)context {
    
    
}

- (void)modWillEnterForeground:(BHContext *)context {
    
    NSLog(@"====");
}

- (void)modDidEnterBackground:(BHContext *)context {
    
    NSLog(@"====");
}

@end
