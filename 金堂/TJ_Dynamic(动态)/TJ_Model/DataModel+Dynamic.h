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
 *  根据page获取动态关注数据
 *
 *  @param page 页码
 */
- (void)getDynamicConcernsDataWithID:(NSNumber *)ID success:(DataModelBlock)success failure:(DataModelBlock)failure;
/**
 *  根据page获取热点数据
 *
 *  @param page 页码
 */
- (void)getHotspotDataWithDate:(NSString *)date success:(DataModelBlock)success failure:(DataModelBlock)failure;
/**
 *  根据page获取动态活动页数据
 *
 *  @param page 页码
 */
- (void)getDynamicActivityDataWithID:(NSNumber *)ID success:(DataModelBlock)success failure:(DataModelBlock)failure;

@end
