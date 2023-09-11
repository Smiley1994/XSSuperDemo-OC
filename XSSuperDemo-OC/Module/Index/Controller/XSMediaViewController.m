//
//  XSMediaViewController.m
//  XSSuperDemo-OC
//
//  Created by 晓松 on 2018/11/14.
//  Copyright © 2018 GoodMorning. All rights reserved.
//

#import "XSMediaViewController.h"
#import "XSRtmpViewController.h"

#import "XSLiveRoomServerProtocol.h"
#import "XSLiveRoomViewController.h"

#import "XSVideoListServerProtocol.h"
#import "XSVideoListViewController.h"

#import "XSUIMacro.h"
#import "XSMediaCell.h"
#import "XSIndexModel.h"

#import "BeeHive.h"
#import "Masonry.h"

@interface XSMediaViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation XSMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"<< MEDIA >>";
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupData];
    [self createTaleView];
}

- (void)setupData {
    self.dataArray = [[NSMutableArray alloc]init];
    
    XSIndexModel *rtmpModel = [[XSIndexModel alloc] init];
    rtmpModel.title = @"VideoList";
    rtmpModel.type = VIDEO_LIST_CELL;
    [self.dataArray addObject:rtmpModel];
    
    XSIndexModel *liveRoomModel = [[XSIndexModel alloc] init];
    liveRoomModel.title = @"LIVEROOM";
    liveRoomModel.type = LIVE_ROOM_CELL;
    [self.dataArray addObject:liveRoomModel];
    
    XSIndexModel *otherModel = [[XSIndexModel alloc] init];
    otherModel.title = @"OTHER";
    otherModel.type = OTHER_CELL;
    [self.dataArray addObject:otherModel];
    
    [self.tableView reloadData];
}

- (void)createTaleView {
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 60;
    [self.tableView registerClass:[XSMediaCell class] forCellReuseIdentifier:@"MediaCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.inset(0);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSMediaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MediaCell"];
    XSIndexModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XSIndexModel *model = self.dataArray[indexPath.row];
    
    switch (model.type) {
        case VIDEO_LIST_CELL:
            [ self openVideoListViewController];
            break;
            
        case LIVE_ROOM_CELL:
            [ self openLiveRoomViewController];
            break;
            
        case OTHER_CELL:
            
            break;
            
        default:
            break;
    }
}

- (void)openRtmpViewController {
    
    XSRtmpViewController *rtmpViewController = [[XSRtmpViewController alloc] init];
    rtmpViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rtmpViewController animated:YES];
}


- (void)openLiveRoomViewController {
    
    id<XSLiveRoomServerProtocol> liveRoom = [[BeeHive shareInstance] createService:@protocol(XSLiveRoomServerProtocol)];
    
    [self.navigationController pushViewController:(UIViewController *)liveRoom animated:YES];
    
}

- (void)openVideoListViewController {
    
    id<XSVideoListServerProtocol> videoList = [[BeeHive shareInstance] createService:@protocol(XSVideoListServerProtocol)];
    [videoList setupParameter:@{@"key":@"value"}];
    [self.navigationController pushViewController:(XSVideoListViewController *)videoList animated:YES];
    
}


@end
