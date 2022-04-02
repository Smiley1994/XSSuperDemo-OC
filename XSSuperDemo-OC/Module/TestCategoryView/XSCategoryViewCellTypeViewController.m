//
//  XSCategoryViewCellTypeViewController.m
//  XSSuperDemo-OC
//
//  Created by Macrolor on 2022/4/2.
//  Copyright © 2022 GoodMorning. All rights reserved.
//

#import "XSCategoryViewCellTypeViewController.h"
#import "HFCategoryView.h"

#import "XSUIMacro.h"

@interface XSCategoryViewCellTypeViewController () <HFCategoryViewDelegate>

@property (nonatomic, strong) HFCategoryTitleImageView *categoryView;
@property (nonatomic, assign) HFCategoryTitleImageType currentType;

@end

@implementation XSCategoryViewCellTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createCategoryView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 200, 100, 50);
    [button setTitle:@"Click" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)createCategoryView {
    
    HFCategoryIndicatorLineView *lineView = [[HFCategoryIndicatorLineView alloc] init];
//    lineView.indicatorColor = [UIColor blackColor];
    lineView.indicatorWidth = 20;
    
    NSArray *titles = @[@"螃蟹", @"小龙虾", @"苹果", @"胡萝卜", @"葡萄", @"西瓜"];
    NSArray *imageNames = @[@"crab", @"lobster", @"apple", @"carrot", @"grape", @"watermelon"];
    NSArray *selectedImageNames = @[@"crab_selected", @"lobster_selected", @"apple_selected", @"carrot_selected", @"grape_selected", @"watermelon_selected"];
    
    // 文字 + 图片
//    self.categoryView = [[HFCategoryTitleImageView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, SCREEN_WIDTH, 50)];
//    self.categoryView.titles = titles;
//    self.categoryView.imageNames = imageNames;
//    self.categoryView.selectedImageNames = selectedImageNames;
//    self.categoryView.imageZoomEnabled = YES;
//    self.categoryView.imageZoomScale = 1.3;
//    self.categoryView.delegate = self;
//    self.categoryView.averageCellSpacingEnabled = NO;
//
//    self.categoryView.indicators = @[lineView];
//
//    [self.view addSubview:self.categoryView];
    
    
    // 只显示文字
    HFCategoryTitleView *titleCategoryView = [[HFCategoryTitleView alloc] init];
    titleCategoryView.frame = CGRectMake(0, NAVIGATION_HEIGHT, SCREEN_WIDTH, 50);
    titleCategoryView.delegate = self;
    titleCategoryView.titles = titles;
    titleCategoryView.titleColorGradientEnabled = YES;
    titleCategoryView.titleLabelZoomEnabled = YES;
    titleCategoryView.titleLabelZoomScale = 1.1;
    titleCategoryView.titleLabelStrokeWidthEnabled = YES;
    titleCategoryView.selectedAnimationEnabled = YES;
    titleCategoryView.cellWidthZoomEnabled = YES;
    titleCategoryView.cellWidthZoomScale = 1.1;
    titleCategoryView.indicators = @[lineView];
    
    [self.view addSubview:titleCategoryView];
    
    
    
}

- (void)categoryView:(HFCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
}

- (void)categoryView:(HFCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    
}

- (void)categoryView:(HFCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    
}

- (void)click {
    [self.categoryView selectItemAtIndex:4];
}

@end
