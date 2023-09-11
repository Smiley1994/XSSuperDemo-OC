//
//  XSVideoListViewController.m
//  XSSuperDemo-OC
//
//  Created by mt230824 on 2023/9/11.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import "XSVideoListViewController.h"
#import "XSVideoListServerProtocol.h"

#import "BeeHive.h"

@interface XSVideoListViewController ()<XSVideoListServerProtocol>

@end

@BeeHiveService(XSVideoListServerProtocol, XSVideoListViewController)
@implementation XSVideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

#pragma mark - XSVideoListServerProtocol

- (void)setupParameter:(NSDictionary *)parameter {
    
}


@end
