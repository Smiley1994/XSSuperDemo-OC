//
//  XSVideoListViewController.h
//  XSSuperDemo-OC
//
//  Created by mt230824 on 2023/9/11.
//  Copyright © 2023 GoodMorning. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSVideoListViewController<V,VM> : UIViewController

@property (nonatomic, strong) V viewBinding;

@property (nonatomic, strong) VM viewModel;

@end

NS_ASSUME_NONNULL_END
