//
//  GKLandscapeWindow.h
//  Example
//
//  Created by XXXXXX on 2023/3/31.
//  Copyright © 2023 XXXXXX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GKRotationManager;

@interface GKLandscapeWindow : UIWindow

@property (nonatomic, weak, nullable) GKRotationManager *rotationManager;

@end

NS_ASSUME_NONNULL_END
