//
//  XSLocaServerManager.m
//  XSSuperDemo-OC
//
//  Created by mt230824 on 2023/9/14.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import "XSLocaServerManager.h"

#import <GCDWebServer/GCDWebServer.h>

@interface XSLocaServerManager ()

@property (nonatomic, strong) GCDWebServer *webServer;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation XSLocaServerManager

+ (XSLocaServerManager *)shareManager {
    
    static dispatch_once_t once;
    static XSLocaServerManager *shareManager;
    dispatch_once(&once, ^{
        shareManager = [[XSLocaServerManager alloc] init];
    });
    
    return shareManager;
}

- (void)starWebServer:(NSString *)filePath fileName:(NSString *)fileName {
    
    [self.webServer addGETHandlerForBasePath:@"/" directoryPath:filePath indexFilename:fileName cacheAge:3600 allowRangeRequests:YES];
    
    NSLog(@"local server url == %@",self.webServer.serverURL);
    
    [self.webServer start];
    
}

- (GCDWebServer *)webServer {
    if (!_webServer) {
        _webServer = [[GCDWebServer alloc] init];
    }
    return _webServer;
}

@end
