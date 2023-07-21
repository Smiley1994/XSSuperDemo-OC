//
//  ZGLocationManager.h
//  XSSuperDemo-OC
//
//  Created by Good_Morning_ on 2020/5/29.
//  Copyright © 2020 GoodMorning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^XSLocationSuccess) (double lng,double lat);
typedef void(^XSLocationFailed) (NSError *error);

@interface XSLocationManager : NSObject<CLLocationManagerDelegate> {
    
    CLLocationManager *manager;
    XSLocationSuccess successCallBack;
    XSLocationFailed failedCallBack;
    
}

+ (XSLocationManager *)sharedManager;

+ (void)getZGLocationWithSuccess:(XSLocationSuccess)success failed:(XSLocationFailed)failed;

+ (void)stop;

@end

NS_ASSUME_NONNULL_END
