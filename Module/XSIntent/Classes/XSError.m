//
//  XSError.m
//  XSIntent
//
//  Created by mt230824 on 2023/10/9.
//

#import "XSError.h"
#import "XSErrorCode.h"

@implementation XSError

- (instancetype)initWithCode:(NSInteger)code{
    if(self = [super init]) {
        self.code = code;
        self.reason = nil;
    }
    return self;
}

- (instancetype)initWithCode:(NSInteger)code andReason:(NSString *)reason {
    if(self = [super init]) {
        self.code = code;
        self.reason = reason;
    }
    return self;
}

+ (instancetype)ok {
    return [[XSError alloc] initWithCode:XS_ERROR_OK];
}

+ (instancetype)unknown {
    return [[XSError alloc] initWithCode:XS_ERROR_UNKNOWN_ERROR andReason:@"未知错误"];
}

+ (instancetype)errorWithCode:(NSInteger)code {
    return [[XSError alloc] initWithCode:code];
}

+ (instancetype)errorWithCode:(NSInteger)code andReason:(NSString *)reason {
    return [[XSError alloc] initWithCode:code andReason:reason];
}

@end
