//
//  XSCrashViewController.h
//  XSCrashViewController
//
//  Created by Macrolor  on 2021/9/27.
//  Copyright © 2021 GoodMorning. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^sendValue)(NSString *text);

@interface XSCrashViewController : UIViewController

@property (nonatomic, copy)sendValue sendValueBlock;

@end

NS_ASSUME_NONNULL_END
