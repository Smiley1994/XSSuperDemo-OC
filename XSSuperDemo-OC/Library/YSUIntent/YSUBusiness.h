//
//  YSUBusiness.h
//  Common
//
//  Created by 孙晓松 on 2016/12/13.
//  Copyright © 2016年 秦皇岛商之翼网络科技有限公司. All rights reserved.
//

#ifndef YSUBusiness_h
#define YSUBusiness_h

#pragma mark - String function
#define YSUBUNDLE [NSBundle bundleWithIdentifier:@"com.super.intent"]
#define LOCALIZE(arg) [YSUBUNDLE localizedStringForKey:(arg) value:@"" table:nil]
#define LOCALIZE_FORMAT(format,arg,...) [NSString stringWithFormat:LOCALIZE(format),arg]

#endif /* YSUBusiness_h */
