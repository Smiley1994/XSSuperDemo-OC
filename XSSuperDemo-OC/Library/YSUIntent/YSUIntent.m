//
//  YSUIntent.m
//  YiShop
//
//  Created by 孙晓松 on 2016/11/14.
//  Copyright © 2016年 秦皇岛商之翼网络科技有限公司. All rights reserved.
//

#import "YSUIntent.h"

@interface YSUIntent()

@property (nonatomic,strong) NSMutableDictionary *data;

@end

@implementation YSUIntent

- (instancetype)initWithClassName:(NSString *)className {
    self = [super init];
    if(self){
        self.data = [[NSMutableDictionary alloc]init];
        self.method = OPEN_METHOD_PUSH;
        self.animated = YES;
        self.className = className;
    }
    
    return self;
}

+ (instancetype)intentWithClassName:(NSString *)className {
    return  [[YSUIntent alloc]initWithClassName:className];
}

- (instancetype)init {
    self = [super init];
    if(self){
        self.data = [[NSMutableDictionary alloc]init];
        self.method = OPEN_METHOD_PUSH;
        self.animated = YES;
    }
    return self;
}

- (void)setObject:(id)object forKey:(NSString *)key {
    [self.data setObject:object forKey:key];
}

- (NSDictionary *)getIntentData{
    return self.data;
}

- (id)objectForKey:(NSString *)key {
    return [self.data objectForKey:key];
}

@end
