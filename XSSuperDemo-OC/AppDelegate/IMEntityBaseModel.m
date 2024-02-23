//
//  IMEntityBaseModel.m
//  library_im
//
//  Created by mt on 2023/12/4.
//

#import "IMEntityBaseModel.h"
#import <objc/runtime.h>

@implementation IMEntityBaseModel

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        [self decodePropertiesWithCoder:coder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [self encodePropertiesWithCoder:coder];
}

- (void)decodePropertiesWithCoder:(NSCoder *)coder {
    Class currentClass = [self class];
    while (currentClass && currentClass != [NSObject class]) {
        unsigned int count;
        objc_property_t *properties = class_copyPropertyList(currentClass, &count);

        for (unsigned int i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            NSString *key = [NSString stringWithUTF8String:propertyName];

            // 获取属性的类型
            const char *attr = property_getAttributes(property);
            NSString *typeString = [NSString stringWithUTF8String:attr];

            id value = nil;

            if ([typeString hasPrefix:@"T@"]) {
                // 对象类型
                value = [coder decodeObjectForKey:key];
            } else if ([typeString hasPrefix:@"Ti"] || [typeString hasPrefix:@"TI"] ||
                       [typeString hasPrefix:@"Ts"] || [typeString hasPrefix:@"TS"] ||
                       [typeString hasPrefix:@"Tq"] || [typeString hasPrefix:@"TQ"]) {
                // 整数类型 (int, unsigned int, short, unsigned short, long, unsigned long, long long, unsigned long long)
                value = @([coder decodeIntegerForKey:key]);
            } else if ([typeString hasPrefix:@"Tf"]) {
                // 浮点数类型 (float)
                value = @([coder decodeFloatForKey:key]);
            } else if ([typeString hasPrefix:@"Td"]) {
                // 双精度浮点数类型 (double)
                value = @([coder decodeDoubleForKey:key]);
            }

            if (value) {
                [self setValue:value forKey:key];
            }
        }

        free(properties);
        currentClass = class_getSuperclass(currentClass);
    }
}

- (void)encodePropertiesWithCoder:(NSCoder *)coder {
    Class currentClass = [self class];
    while (currentClass && currentClass != [NSObject class]) {
        unsigned int count;
        objc_property_t *properties = class_copyPropertyList(currentClass, &count);

        for (unsigned int i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            NSString *key = [NSString stringWithUTF8String:propertyName];

            // 获取属性的类型
            const char *attr = property_getAttributes(property);
            NSString *typeString = [NSString stringWithUTF8String:attr];

            id value = [self valueForKey:key];

            if ([typeString hasPrefix:@"T@"]) {
                // 对象类型
                [coder encodeObject:value forKey:key];
            } else if ([typeString hasPrefix:@"Ti"] || [typeString hasPrefix:@"TI"] ||
                       [typeString hasPrefix:@"Ts"] || [typeString hasPrefix:@"TS"] ||
                       [typeString hasPrefix:@"Tq"] || [typeString hasPrefix:@"TQ"]) {
                // 整数类型 (int, unsigned int, short, unsigned short, long, unsigned long, long long, unsigned long long)
                [coder encodeInteger:[value integerValue] forKey:key];
            } else if ([typeString hasPrefix:@"Tf"]) {
                // 浮点数类型 (float)
                [coder encodeFloat:[value floatValue] forKey:key];
            } else if ([typeString hasPrefix:@"Td"]) {
                // 双精度浮点数类型 (double)
                [coder encodeDouble:[value doubleValue] forKey:key];
            }
        }

        free(properties);
        currentClass = class_getSuperclass(currentClass);
    }
}

@end
