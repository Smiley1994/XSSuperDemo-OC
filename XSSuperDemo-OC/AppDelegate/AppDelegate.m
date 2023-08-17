//
//  AppDelegate.m
//  XSSuperDemo-OC
//
//  Created by Good_Morning_ on 2018/6/28.
//  Copyright © 2018年 GoodMorning. All rights reserved.
//

#import "AppDelegate.h"
#import "BeeHive.h"
#import "BHTimeProfiler.h"
#import "BHModuleManager.h"
#import "BHServiceManager.h"

#import "XSSplashServerProtocol.h"
#import "XSSplashViewController.h"

#import "QiCallTrace.h"
//#import "Sentry.h"
#import "ShadowBase.h"

#import "XSPeople.h"
#import "XSSubPeople.h"

#import <mach-o/dyld.h>

@interface AppDelegate ()

@end


// 需要用extern修饰才能在外部访问
extern void _objc_autoreleasePoolPrint(void);

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [QiCallTrace start];
    
    // setup BeeHive
    [BHContext shareInstance].application = application;
    [BHContext shareInstance].launchOptions = launchOptions;
//    [BHContext shareInstance].moduleConfigName = @"BeeHive.bundle/BeeHive";//可选，默认为BeeHive.bundle/BeeHive.plist
//    [BHContext shareInstance].serviceConfigName = @"BeeHive.bundle/BHService";
    
    [BeeHive shareInstance].enableException = YES;
    [[BeeHive shareInstance] setContext:[BHContext shareInstance]];
    [[BHTimeProfiler sharedTimeProfiler] recordEventTime:@"BeeHive::super start launch"];
    
    [[BHModuleManager sharedManager] triggerEvent:BHMSetupEvent];
    [[BHModuleManager sharedManager] triggerEvent:BHMInitEvent];

    
    id<XSSplashServerProtocol> plash = [[BeeHive shareInstance] createService:@protocol(XSSplashServerProtocol)];
    [plash setupParameter:@{@"key":@"value"}];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:(XSSplashViewController *)plash];
    self.window.rootViewController = navigationViewController;
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = UIColor.whiteColor;

//    [self setupShadowBase:launchOptions];
//    [self setupBugly];
//    [self setupSenty];

//    [QiCallTrace stop];
//    [QiCallTrace save];
    
//    [self testGCD];

    
    return YES;
}


- (void)testGCD {
    
    NSLog(@"test gcd\n");
    
    dispatch_queue_t queueSerial = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t queueConcurrent = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
     
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    
//    dispatch_async(queueSerial, ^{    // 异步执行 + 串行队列
//        dispatch_sync(queueSerial, ^{  // 同步执行 + 当前串行队列
//            // 追加任务 1
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//        });
//    });
    /**
     执行上面的代码会导致 串行队列中追加的任务 和 串行队列中原有的任务 两者之间相互等待，阻塞了『串行队列』，最终造成了串行队列所在的线程（子线程）死锁问题。
     主队列造成死锁也是基于这个原因，所以，这也进一步说明了主队列其实并不特殊。
     */
    
    
    NSLog(@"当前线程 == %@",[NSThread currentThread]);
    
    NSLog(@"begin concurrent");
    
    
    dispatch_sync(mainQueue, ^{
        
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1当前线程 == %@",[NSThread currentThread]);
        
    });
    
    dispatch_async(mainQueue, ^{
        
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2当前线程 == %@",[NSThread currentThread]);
        
    });
    
    dispatch_async(mainQueue, ^{
        
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3当前线程 == %@",[NSThread currentThread]);
        
    });
    
    dispatch_async(mainQueue, ^{
        
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4当前线程 == %@",[NSThread currentThread]);
        
    });
    
    NSLog(@"end concurrent");
    
}

void testOperationQueque(void) {
    

    /**
     * 创建的任何新线程都有一个与之关联的默认优先级。
     * `内核调度算法` 在决定该运行哪个线程时，会把线程的优先级作为考量因素，较高优先级的线程会比较低优先级的线程具有更多的运行机会。
     * 较高优先级不保证你的线程具体执行的时间，只是相比较低优先级的线程，它更有可能被调度器选择执行而已。
     * 高优先级的线程并不一定会比低优先级的线程先执行。并且在 iOS 中线程优先级在串行队列中实际意义更大一些
     */

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    queue.maxConcurrentOperationCount = 10;
    
    NSInteger count = 20;
    
    for (NSInteger i = 0; i < count; i++) {
    
        //创建任务
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
          NSLog(@"== %@",@(i));
        }];
        
        op.queuePriority = (i%2 == 0) ? NSOperationQueuePriorityVeryLow : NSOperationQueuePriorityVeryHigh;
        
        [queue addOperation:op];
      
    }
      
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    
}

void testAutoRelease(void){

    @autoreleasepool {
        for (NSInteger i = 0; i < 1000; i++) {
            @autoreleasepool {
                NSObject *temp = [[NSObject alloc] init];
            }

            _objc_autoreleasePoolPrint();

        }
    }
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
    
    [[BHModuleManager sharedManager] triggerEvent:BHMDidEnterBackgroundEvent];
    
//    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^(){
//        //iOS7 以后在后台大概能够运行3分钟，iOS7 以前大概能够运行10分钟，注意后台任务结束后需要执行 endBackgroundTaskNSLog(@"程序关闭");
//    }];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    [[BHModuleManager sharedManager] triggerEvent:BHMWillEnterForegroundEvent];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
