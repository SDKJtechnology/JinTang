//
//  DynamicDataModel.h
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  动态网络请求模型
 *
 *  @param data 请求完成模型组
 */
typedef void (^DynamicNetworkingBlock)(id data);

@interface DynamicNetworkingModel : NSObject

/**
 *  单例初始化方法
 *
 *  @return dynamicNetworkingModel Obejct
 */
+ (instancetype)sharedObejct;
/**
 *  根据page获取动态数据
 *
 *  @param page 页码
 */
- (void)getDynamicDataWithPage:(NSNumber *)page success:(DynamicNetworkingBlock)success failure:(DynamicNetworkingBlock)failure;
/**
 *  根据page获取热点数据
 *
 *  @param page 页码
 */
- (void)getHotspotDataWithPage:(NSNumber *)page success:(DynamicNetworkingBlock)success failure:(DynamicNetworkingBlock)failure;

@end
