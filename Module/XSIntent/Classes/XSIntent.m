//
//  XSIntent.m
//  XSIntent
//
//  Created by mt230824 on 2023/10/9.
//

#import "XSIntent.h"

@interface XSIntent ()

@property (nonatomic,strong) NSMutableDictionary *data;

@end

@implementation XSIntent

- (instancetype)initWithClassName:(NSString *)className {
    if(self = [super init]){
        self.data = [[NSMutableDictionary alloc]init];
        self.method = OPEN_METHOD_PUSH;
        self.animated = YES;
        self.className = className;
    }
    
    return self;
}

+ (instancetype)intentWithClassName:(NSString *)className {
    return  [[XSIntent alloc]initWithClassName:className];
}

- (void)setObject:(id)object forKey:(NSString *)key {
    [self.data setObject:object forKey:key];
}

- (NSDictionary *)intentData{
    return self.data;
}

- (id)objectForKey:(NSString *)key {
    return [self.data objectForKey:key];
}

@end
