//
//  XSSubPeople.m
//  XSSuperDemo-OC
//
//  Created by GoodMorning on 2023/7/22.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import "XSSubPeople.h"

@interface XSSubPeople ()

@property (nonatomic, copy) NSString *testString;

@end

@implementation XSSubPeople

- (instancetype)init {
    if (self = [super init]) {
        
        self.testString = @"aaaaaa";
        
    }
    return self;
}

+ (void)initialize {
    NSLog(@"%s",__func__);
}

@end
