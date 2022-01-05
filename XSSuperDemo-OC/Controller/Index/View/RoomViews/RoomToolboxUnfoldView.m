//
//  RoomToolboxUnfoldView.m
//  RoomToolboxUnfoldView
//
//  Created by Macrolor on 2021/12/8.
//  Copyright © 2021 GoodMorning. All rights reserved.
//

#import "RoomToolboxUnfoldView.h"
#import "RoomToolboxUnfoldCell.h"
#import "RoomToolboxUnfoldCellModel.h"

@interface RoomToolboxUnfoldView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation RoomToolboxUnfoldView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        [self setupDatas];
    }
    return self;
}

- (void)setupDatas {
    
    RoomToolboxUnfoldCellModel *beautyModel = [[RoomToolboxUnfoldCellModel alloc] init];
    beautyModel.title = @"美颜";
    beautyModel.imageName = @"";
    [self.dataArray addObject:beautyModel];
    
    RoomToolboxUnfoldCellModel *stickerModel = [[RoomToolboxUnfoldCellModel alloc] init];
    stickerModel.title = @"贴纸";
    stickerModel.imageName = @"";
    [self.dataArray addObject:stickerModel];
    
    RoomToolboxUnfoldCellModel *bigPrintModel = [[RoomToolboxUnfoldCellModel alloc] init];
    bigPrintModel.title = @"大字";
    bigPrintModel.imageName = @"";
    [self.dataArray addObject:bigPrintModel];
    
    RoomToolboxUnfoldCellModel *mirrorImageModel = [[RoomToolboxUnfoldCellModel alloc] init];
    mirrorImageModel.title = @"镜像";
    mirrorImageModel.imageName = @"";
    [self.dataArray addObject:mirrorImageModel];
    
    RoomToolboxUnfoldCellModel *flipModel = [[RoomToolboxUnfoldCellModel alloc] init];
    flipModel.title = @"翻转";
    flipModel.imageName = @"";
    [self.dataArray addObject:flipModel];
    
    RoomToolboxUnfoldCellModel *transferModel = [[RoomToolboxUnfoldCellModel alloc] init];
    transferModel.title = @"转移";
    transferModel.imageName = @"";
    [self.dataArray addObject:transferModel];
    
    RoomToolboxUnfoldCellModel *muteModel = [[RoomToolboxUnfoldCellModel alloc] init];
    muteModel.title = @"静音";
    muteModel.imageName = @"";
    [self.dataArray addObject:muteModel];
    
    RoomToolboxUnfoldCellModel *leaveModel = [[RoomToolboxUnfoldCellModel alloc] init];
    leaveModel.title = @"离开";
    leaveModel.imageName = @"";
    [self.dataArray addObject:leaveModel];
    
    [self.collectionView reloadData];
}

- (void)setupUI {
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 30.f;
    layout.minimumInteritemSpacing = 24.5f;
    
    self.collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 38, 110, 297) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 15, 19.5, 15);
    [self.collectionView registerClass:[RoomToolboxUnfoldCell class] forCellWithReuseIdentifier:RoomToolboxUnfoldCellIdentify];
    [self addSubview:self.collectionView];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(25, 25 + 11 + 2);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RoomToolboxUnfoldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RoomToolboxUnfoldCellIdentify forIndexPath:indexPath];
    [cell setupModel:self.dataArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
