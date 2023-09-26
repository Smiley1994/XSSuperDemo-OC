//
//  XSFileHandleTool.h
//  XSSuperDemo-OC
//
//  Created by mt230824 on 2023/9/20.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSFileHandleTool : NSObject

//读句柄
@property (nonatomic, strong) NSFileHandle *readHandle;
//写句柄
@property (nonatomic, strong) NSFileHandle *descHandle;
//句柄偏移量
@property (nonatomic, assign) unsigned long long offset;
//总包数
@property (nonatomic, assign) NSUInteger totalPackage;
//当前包数
@property (nonatomic, assign) NSUInteger currentPackage;

@property (nonatomic, strong) NSString *checksum;


/// 读数据
-(NSData *)readData;

/// 读写数据
-(void)readAndWriteData;

/// 写数据
-(void)writeDataWithData:(NSData*)data;

/// 创建服务器写句柄
-(void)creatReadServerFileHandelFileName:(NSString*)fileName totalPackage:(NSUInteger)total;

/// 创建读本地句柄
- (void)creatReadLocalFileHandelName:(NSString *)fileName ofType:(NSString *)ofType;

/// 创建读写句柄
-(void)creatReadAndWriteFileHandelName:(NSString*)fileName;


@end

NS_ASSUME_NONNULL_END
