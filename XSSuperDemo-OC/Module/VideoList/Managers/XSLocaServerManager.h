//
//  XSLocaServerManager.h
//  XSSuperDemo-OC
//
//  Created by mt230824 on 2023/9/14.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define LocalServer [XSLocaServerManager shareManager];

@interface XSLocaServerManager : NSObject

+ (XSLocaServerManager *)shareManager;

- (void)starWebServer:(NSString *)filePath fileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
