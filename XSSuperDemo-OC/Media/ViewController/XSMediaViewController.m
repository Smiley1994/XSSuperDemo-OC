//
//  XSMediaViewController.m
//  XSSuperDemo-OC
//
//  Created by 晓松 on 2018/11/14.
//  Copyright © 2018 GoodMorning. All rights reserved.
//

#import "XSMediaViewController.h"
#import "XSRtmpViewController.h"
#import "XSUIMacro.h"
#import "XSMediaCell.h"
#import "XSIndexModel.h"

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
    rtmpModel.title = @"RTMP Player";
    rtmpModel.type = MEDIA_CELL;
    [self.dataArray addObject:rtmpModel];
    
    XSIndexModel *otherModel = [[XSIndexModel alloc] init];
    otherModel.title = @"OTHER";
    otherModel.type = OTHER_CELL;
    [self.dataArray addObject:otherModel];
    
    [self.tableView reloadData];
}

- (void)createTaleView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 60;
    [self.tableView registerClass:[XSMediaCell class] forCellReuseIdentifier:@"MediaCell"];
    [self.view addSubview:self.tableView];
    
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
    NSLog(@"%s------>%ld", __FUNCTION__,(long)indexPath.row);
    XSIndexModel *model = self.dataArray[indexPath.row];
    
    switch (model.type) {
        case MEDIA_CELL:
            [ self openRtmpViewController];
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


@end
