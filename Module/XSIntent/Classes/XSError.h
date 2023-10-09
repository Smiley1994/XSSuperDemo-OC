//
//  XSError.h
//  XSIntent
//
//  Created by mt230824 on 2023/10/9.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface XSError : NSObject

/// error code
@property (nonatomic, assign) NSInteger code;

/// error reason
@property (nonatomic, strong) NSString * __nullable reason;

- (instancetype)initWithCode:(NSInteger)code;
- (instancetype)initWithCode:(NSInteger)code andReason:(NSString *)reason;

+ (instancetype)ok;
+ (instancetype)unknown;
+ (instancetype)errorWithCode:(NSInteger)code;
+ (instancetype)errorWithCode:(NSInteger)code andReason:(NSString *)reason;

@end

NS_ASSUME_NONNULL_END
