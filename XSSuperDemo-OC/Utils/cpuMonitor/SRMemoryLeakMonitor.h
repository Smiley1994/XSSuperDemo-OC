//
//  SRMemoryLeakMonitor.h
//  v6cn-iPhone
//
//  Created by Boris on 2023/6/20.
//  Copyright © 2023 Darcy Niu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRMemoryLeakMonitor : NSObject

+ (instancetype)sharedInstance;

- (void)startMonitoring;

@end

NS_ASSUME_NONNULL_END
