//
//  DynamicActivityModel.h
//  金堂
//
//  Created by SDKJ on 16/4/29.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicConcernsModel.h"

@interface DynamicActivityModel : DynamicConcernsModel
/**
 *  活动开始时间
 */
@property (nonatomic, strong) NSNumber *startDate;
/**
 * 活动结束时间
 */
@property (nonatomic, strong) NSNumber *endDate;

@end
