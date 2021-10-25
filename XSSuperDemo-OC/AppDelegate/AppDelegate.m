//
//  AppDelegate.m
//  XSSuperDemo-OC
//
//  Created by Good_Morning_ on 2018/6/28.
//  Copyright © 2018年 GoodMorning. All rights reserved.
//

#import "AppDelegate.h"
#import "XSSplashViewController.h"
//#import "Sentry.h"
#import "ShadowBase.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    XSSplashViewController *splashViewcontroller = [[XSSplashViewController alloc] init];
    UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:splashViewcontroller];
    self.window.rootViewController = navigationViewController;
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = UIColor.whiteColor;
    
    [self setupShadowBase:launchOptions];
//    [self setupBugly];
    [self setupSenty];
    
    return YES;
}

- (void)setupShadowBase:(NSDictionary *)launchOptions {
    
    [[ShadowBase shareInstance] enableExceptionTrack];
    [[ShadowBase shareInstance] startWithAppKey:@"appkey" launchOptions:launchOptions];
    
    
}

- (void)setupBugly {
//    [Bugly startWithAppId:@"663e2a47f8"];
}

- (void)setupSenty {
    
//    [SentrySDK startWithConfigureOptions:^(SentryOptions *options) {
//        options.dsn = @"https://49fbfb5373254e4e90094205ebcdf9d9@appsentry.6.cn/6";
//        options.debug = YES;
//        options.sessionTrackingIntervalMillis = [@5000 unsignedIntegerValue];
//        // Sampling 100% - In Production you probably want to adjust this
//        options.tracesSampleRate = @1.0;
//    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
