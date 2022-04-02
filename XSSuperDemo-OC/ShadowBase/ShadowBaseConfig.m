//
//  ShadowBaseConfig.m
//  XSSuperDemo-OC
//
//  Created by Macrolor  on 2021/9/8.
//  Copyright © 2021 GoodMorning. All rights reserved.
//

#import "ShadowBaseConfig.h"

/* 默认应用版本 */
#define SB_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/*应用名称*/
#define SB_APP_NAME [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];


@implementation ShadowBaseConfig

- (instancetype)init {
    
    if (self = [super init]) {
        self.sdkVersion = SB_SDK_VERSION;
        self.appVersion = SB_APP_VERSION;
        self.appName = SB_APP_NAME;
        self.sendInterval = 10;
        self.sendMaxSizePerDay = 50000;
        self.cacheMaxSize = 50000;
    }
    
    return self;
}

@end
