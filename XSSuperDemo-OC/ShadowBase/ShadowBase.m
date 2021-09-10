//
//  ShadowBase.m
//  XSSuperDemo-OC
//
//  Created by Macrolor on 2021/9/8.
//  Copyright © 2021 GoodMorning. All rights reserved.
//

#import "ShadowBase.h"
#import "SBLog.h"


@interface ShadowBase ()

@property (nonatomic, strong) ShadowBaseConfig *config;
@property (nonatomic, strong) NSString *appkey;

@end

static NSUncaughtExceptionHandler *previousHandler;

@implementation ShadowBase

+ (ShadowBase *)shareInstance {
    static ShadowBase *shadowBase = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shadowBase = [[self alloc] init];
        shadowBase.config = [[ShadowBaseConfig alloc] init];
    });
    return shadowBase;
}

- (void)startWithAppKey:(NSString *)appKey launchOptions:(NSDictionary *)launchOptions {
    
    if (!appKey || appKey.length == 0) {
        SBLogWarning(@"请填写正确 appkey");
        return;
    }
    
    if (self.config.isEnableExceptionTrack) {
        previousHandler = NSGetUncaughtExceptionHandler();
        NSSetUncaughtExceptionHandler(&shadowBaseUncaughtExceptionHandler);
    }
    
    if (self.config.enableAutoTrack) {
        
    }
    
}

- (ShadowBaseConfig *)config {
    return _config;
}

- (void)enableExceptionTrack {
    self.config.isEnableExceptionTrack = YES;
}

// 出现崩溃时的回调函数
void shadowBaseUncaughtExceptionHandler(NSException * exception){
    [[ShadowBase shareInstance] trackException:exception];
}

// 上报崩溃日志
//- (void)trackException:(NSException *)exception {
//    NSArray<NSString *> *symbols = [exception callStackSymbols];
//    NSString * reason = [exception reason]; // 崩溃的原因  可以有崩溃的原因(数组越界,字典nil,调用未知方法...) 崩溃的控制器以及方法
//    NSString * name = [exception name];
//    NSMutableString *stack = [NSMutableString string];
//    long sum = 0;
//    for (NSString *ele in symbols) {
//        sum = sum + ele.length;
//        if ((sum + 5) >256) {
//            break;
//        }
//        [stack appendString:[ele stringByReplacingOccurrencesOfString:@" " withString:@""]];
//        [stack appendString:@" \n "];
//    }
//    NSMutableDictionary *pr = [[NSMutableDictionary alloc] init];
//    pr[@"$exception_name"]=name;
//    pr[@"$exceoption_reson"]=reason;
//    pr[@"$exceptoin_stack"] = stack;
//    pr[@"$异常进程名称"]= [[NSProcessInfo processInfo] processName];
//
//    SBLogInfo([self encodeAPIData:pr]);
//
//    NSLog(@"exception callStackSymbols == %@",[exception callStackSymbols]);
//}

- (void)trackException:(NSException *)exception {
    
    NSArray<NSString *> *symbols = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSDictionary *userInfo = [exception userInfo];
    NSString *name = [exception name];
    
    SBLogError(@"exception callStackSymbols == %@",symbols);
    
}

- (void)track:(NSString *)event {
    
}

- (void)track:(NSString *)event properties:(NSDictionary *)properties {
    
}

- (void)autoTrack:(NSDictionary *)properties {
    
}


- (void)writeLogWithMessage:(NSString *)message {
    
}

// API数据编码
- (NSString *)encodeAPIData:(NSMutableDictionary *) batch {
    NSData *data = [self JSONSerializeObject:batch];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

// JSON序列化
- (NSData *)JSONSerializeObject:(id)obj {
    id coercedObj = [self JSONSerializableObjectForObject:obj];
    NSError *error = nil;
    NSData *data = nil;
    @try {
        data = [NSJSONSerialization dataWithJSONObject:coercedObj options:0 error:&error];
    }
    @catch (NSException *exception) {
        SBLogError(@"%@ exception encoding api data: %@", self, exception);
    }
    if (error) {
        SBLogError(@"%@ error encoding api data: %@", self, error);
        
    }
    return data;
}

// JSON序列化
- (id)JSONSerializableObjectForObject:(id)obj {
    // valid json types
    if ([obj isKindOfClass:[NSString class]] ||
        [obj isKindOfClass:[NSNumber class]] ||
        [obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
    // recurse on containers
    if ([obj isKindOfClass:[NSArray class]]) {
        NSMutableArray *a = [NSMutableArray array];
        for (id i in obj) {
            [a addObject:[self JSONSerializableObjectForObject:i]];
        }
        return [NSArray arrayWithArray:a];
    }
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *d = [NSMutableDictionary dictionary];
        for (id key in obj) {
            NSString *stringKey;
            if (![key isKindOfClass:[NSString class]]) {
                stringKey = [key description];
            } else {
                stringKey = [NSString stringWithString:key];
            }
            id v = [self JSONSerializableObjectForObject:obj[key]];
            d[stringKey] = v;
        }
        return [NSDictionary dictionaryWithDictionary:d];
    }
    
    // default to sending the object's description
    NSString *s = [obj description];
    return s;
}

@end
