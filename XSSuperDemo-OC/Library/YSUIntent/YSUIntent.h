//
//  YSUIntent.h
//  YiShop
//
//  Created by 孙晓松 on 2016/11/14.
//  Copyright © 2016年 秦皇岛商之翼网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSUIntent;
@class YSUError;

@protocol UIViewControllerIntentDelegate <NSObject>

- (void)willCloseViewController:(__kindof UIViewController *)viewController withIntent:(YSUIntent *)intent;

- (YSUError*)willOpenViewController:(__kindof UIViewController *)viewController withIntent:(YSUIntent *)intent;

- (void)onViewController:(__kindof UIViewController *)viewController ofRequestCode:(NSInteger)requestCode finshedWithResult:(NSInteger)resultCode andResultData:(NSDictionary *)resultData;

@end

typedef NS_ENUM(NSInteger,OpenViewControllerMethod){
    OPEN_METHOD_PUSH,
    OPEN_METHOD_POP,
    OPEN_METHOD_SHOW
};

@interface YSUIntent : NSObject

@property (nonatomic, assign) BOOL useNavigationToPush;
@property (nonatomic, assign) BOOL hidesBottomBarWhenPushed;
@property (nonatomic, assign) BOOL isRequest;
@property (nonatomic, assign) NSInteger requestCode;
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, strong) NSString *className;
@property (nonatomic, assign) OpenViewControllerMethod method;
@property (nonatomic, weak) id<UIViewControllerIntentDelegate> delegate;

- (NSDictionary *)getIntentData;

- (void)setObject:(id)object forKey:(NSString *)key;

- (id)objectForKey:(NSString *)key;

- (instancetype)initWithClassName:(NSString *)className;

+ (instancetype)intentWithClassName:(NSString *)className;

@end
