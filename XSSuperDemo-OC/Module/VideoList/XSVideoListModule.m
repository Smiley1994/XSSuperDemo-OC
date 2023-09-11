//
//  XSVideoListModule.m
//  XSSuperDemo-OC
//
//  Created by mt230824 on 2023/9/11.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import "XSVideoListModule.h"
#import "BeeHive.h"

@interface XSVideoListModule ()<BHModuleProtocol>

@end

@BeeHiveMod(XSVideoListModule)
@implementation XSVideoListModule

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
