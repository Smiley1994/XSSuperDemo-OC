//
//  XSIndexViewController.m
//  XSSuperDemo-OC
//
//  Created by 晓松 on 2018/11/13.
//  Copyright © 2018 GoodMorning. All rights reserved.
//

#import "XSIndexViewController.h"
#import "XSUIMacro.h"
#import "XSIndexCell.h"
#import "XSIndexModel.h"
#import "XSMediaViewController.h"
#import "XSCardViewController.h"
#import "XSCrashViewController.h"
#import "XSTestViewController.h"
#import "Masonry.h"

@interface XSIndexViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation XSIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self setupData];
    [self createTaleView];
    
}

- (void)setupData {
    self.dataArray = [[NSMutableArray alloc]init];
    
    XSIndexModel *mediaModel = [[XSIndexModel alloc] init];
    mediaModel.title = @"Media";
    mediaModel.type = MEDIA_CELL;
    [self.dataArray addObject:mediaModel];
    
    XSIndexModel *webModel = [[XSIndexModel alloc] init];
    webModel.title = @"WebView";
    webModel.type = WEB_CELL;
    [self.dataArray addObject:webModel];
    
    XSIndexModel *cardModel = [[XSIndexModel alloc] init];
    cardModel.title = @"Card";
    cardModel.type = CARD_CELL;
    [self.dataArray addObject:cardModel];
    
    XSIndexModel *crashModel = [[XSIndexModel alloc] init];
    crashModel.title = @"CRASH";
    crashModel.type = CRASH_CELL;
    [self.dataArray addObject:crashModel];
    
    XSIndexModel *otherModel = [[XSIndexModel alloc] init];
    otherModel.title = @"Other";
    otherModel.type = OTHER_CELL;
    [self.dataArray addObject:otherModel];
    
    [self.tableView reloadData];
}

- (void)createTaleView {
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 60;
    [self.tableView registerClass:[XSIndexCell class] forCellReuseIdentifier:@"IndexCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.inset(0);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexCell"];
    XSIndexModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s------>%ld", __FUNCTION__,(long)indexPath.row);
    XSIndexModel *model = self.dataArray[indexPath.row];
    
    switch (model.type) {
        case MEDIA_CELL:
            [ self openMediaViewController];
            break;
            
        case WEB_CELL:
            [self openWebViewController];
            break;
        case CARD_CELL:
            [self openCardViewController];
            break;
        case CRASH_CELL:
            [self openCrashViewController];
            break;
        case OTHER_CELL:
            [self openTestViewController];
            break;
            
        default:
            break;
    }
}

- (void)crash {
    NSArray *array = @[@"0",@"1",@"2",@"3"];
    [array objectAtIndex:6];
}

- (void)openCardViewController {
    XSCardViewController *cardViewController = [[XSCardViewController alloc] init];
    cardViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cardViewController animated:YES];
}

- (void)openMediaViewController {
    
    XSMediaViewController *mediaViewController = [[XSMediaViewController alloc] init];
    mediaViewController.hidesBottomBarWhenPushed = YES;                                                                                                                                                                                        
    [self.navigationController pushViewController:mediaViewController animated:YES];
}


- (void)openWebViewController {
//    RxWebViewController *webView = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://github.com/Smiley1994"]];
//    webView.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:webView animated:YES];
}

-(void)openCrashViewController {
    XSCrashViewController *crashViewController = [[XSCrashViewController alloc] init];
    crashViewController.hidesBottomBarWhenPushed = YES;
//    __weak XSIndexViewController *firstVC = self;
    
    crashViewController.sendValueBlock = ^(NSString * _Nonnull text) {
        NSLog(@"text == %@",text);
    };
    
    [self.navigationController pushViewController:crashViewController animated:YES];
}

- (void)openTestViewController {
    
    XSTestViewController *test = [[XSTestViewController alloc] init];
    test.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:test animated:YES];
}


@end
