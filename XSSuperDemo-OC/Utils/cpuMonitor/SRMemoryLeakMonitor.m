//
//  SRMemoryLeakMonitor.m
//  v6cn-iPhone
//
//  Created by Boris on 2023/6/20.
//  Copyright © 2023 Darcy Niu. All rights reserved.
//

#import "SRMemoryLeakMonitor.h"
#import <objc/runtime.h>

@interface SRMemoryLeakMonitor ()

@property (nonatomic, strong) NSTimer *moniTimer;

@end

@implementation SRMemoryLeakMonitor


+ (instancetype)sharedInstance {
    
    static SRMemoryLeakMonitor *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SRMemoryLeakMonitor alloc] init];
    });
    return sharedInstance;
}

- (void)startMonitoring {
    // 在此处开始监测内存泄漏
    // 使用 Objective-C 运行时特性来追踪对象的创建和释放
#ifdef DEBUG
    
    // Debug模式下的代码
    [self doStartLeakMonitor];
#else
    // Release模式下不执行
#endif
    
}
- (void)doStartLeakMonitor {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self observeClasses];
    });
}
- (void)observeClasses {
    unsigned int classCount = 0;
    Class *classes = objc_copyClassList(&classCount);

    for (unsigned int i = 0; i < classCount; i++) {
        Class currentClass = classes[i];

        // 只观察NSObject的子类
        if (class_getSuperclass(currentClass) == [NSObject class]) {
            [self observeClass:currentClass];
        }
    }

    free(classes);
}

- (void)observeClass:(Class)class {
    NSString *className = NSStringFromClass(class);
    
    // 过滤系统类或其他你想排除的类
    if (![className hasPrefix:@"UI"] && ![className hasPrefix:@"NS"]) {
        unsigned int methodCount = 0;
        Method *methods = class_copyMethodList(class, &methodCount);
        
        for (unsigned int i = 0; i < methodCount; i++) {
            SEL selector = method_getName(methods[i]);
            NSString *methodName = NSStringFromSelector(selector);
            
            // 检查可能指示内存泄漏的特定方法
            if ([methodName isEqualToString:@"dealloc"] ||
                [methodName isEqualToString:@"didReceiveMemoryWarning"]) {
             
                [self uploadLeakedObjects:[NSString stringWithFormat:@"类名: %@, 方法名：%@", className, methodName]];
            }
        }
        
        free(methods);
    }
}

- (void)uploadLeakedObjects:(NSString *)objs {
   
    // 获取当前堆栈信息并上报...
    NSLog(@"didReceiveMemoryWarning：%@", objs);
}



@end
