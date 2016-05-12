//
//  DataModel.h
//  金堂
//
//  Created by SDKJ on 16/5/12.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  动态网络请求模型
 *
 *  @param data 请求完成模型组
 */
typedef void (^DataModelBlock)(id data);

@interface DataModel : NSObject
/**
 *  单例初始化方法
 *
 *  @return dynamicNetworkingModel Obejct
 */
+ (instancetype)sharedObejct;
@end
