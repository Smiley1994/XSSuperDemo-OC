//
//  MTSortVideoModel.m
//  SortVideoDemo
//
//  Created by mt230824 on 2023/9/4.
//

#import "MTVideoListModel.h"

@implementation MTVideoListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"video_id"  : @"id"};
}

@end
