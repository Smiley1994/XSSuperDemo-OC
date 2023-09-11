//
//  XSVideoListViewController.m
//  XSSuperDemo-OC
//
//  Created by mt230824 on 2023/9/11.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import "XSVideoListViewController.h"
#import "XSVideoListServerProtocol.h"

#import "MTPlayerManager.h"
#import "MTVideoListModel.h"

#import "BeeHive.h"
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import <YYKit/YYKit.h>
#import <MJRefresh/MJRefresh.h>

@interface XSVideoListViewController ()<XSVideoListServerProtocol>

@property (nonatomic, strong) MTPlayerManager *playerManager;

@property (nonatomic, strong) UIButton *backButton;

@end

@BeeHiveService(XSVideoListServerProtocol, XSVideoListViewController)
@implementation XSVideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self setupUI];
    [self requestDatas];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - XSVideoListServerProtocol

- (void)setupParameter:(NSDictionary *)parameter {
    
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.playerManager.verticalSortVideoScrollView];
    [self.playerManager.verticalSortVideoScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(10, 20, 100, 30);
    [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    
    
}

- (void)requestDatas {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *url = [NSString stringWithFormat:@"https://haokan.baidu.com/haokan/ui-web/video/rec?tab=%@&act=pcFeed&pd=pc&num=%d", @"recommend", 15];
    
    __weak typeof(self) weakSelf = self;
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if ([responseObject[@"status"] integerValue] == 0) {
            
            NSArray *videos = responseObject[@"data"][@"response"][@"videos"];
            
            if (strongSelf.playerManager.page == 1) {
                [strongSelf.playerManager.dataSources removeAllObjects];
            }

            [videos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MTVideoListModel *model = [MTVideoListModel modelWithDictionary:obj];
                [strongSelf.playerManager.dataSources addObject:model];
            }];
            
            [strongSelf.playerManager.verticalSortVideoScrollView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)backButtonClick {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (MTPlayerManager *)playerManager {
    if(!_playerManager) {
        _playerManager = [[MTPlayerManager alloc] init];
    }
    return _playerManager;
}

- (void)dealloc {
    
    [self.playerManager reset];
    self.playerManager = nil;
    
}


@end
