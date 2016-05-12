//
//  DataModel+Dynamic.h
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DataModel.h"

@interface DataModel (Dynamic)

/**
 *  根据ID获取动态关注数据
 *
 *  @param ID 帖子id
 */
- (void)getDynamicConcernsDataWithID:(NSNumber *)ID success:(DataModelBlock)success failure:(DataModelBlock)failure;
/**
 *  根据date获取热点数据
 *
 *  @param date 帖子日期
 */
- (void)getHotspotDataWithDate:(NSString *)date success:(DataModelBlock)success failure:(DataModelBlock)failure;
/**
 *  根据ID获取动态活动页数据
 *
 *  @@param ID 帖子id
 */
- (void)getDynamicActivityDataWithID:(NSNumber *)ID success:(DataModelBlock)success failure:(DataModelBlock)failure;

@end
