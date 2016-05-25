//
//  DataModel.h
//  金堂
//
//  Created by SDKJ on 16/5/12.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "MJExtension.h"
#import "NSDictionary Chinese.h"

/**
 *  动态网络请求模型
 *
 *  @param data 请求完成模型组
 */
typedef void (^DataModelBlock)(id data);

@interface DataModel : NSObject

@property (nonatomic, strong, readonly) AFHTTPSessionManager *manager;
/**
 *  单例初始化方法
 *
 *  @return dynamicNetworkingModel Obejct
 */
+ (instancetype)sharedObejct;
/**
 *  图片上传
 *
 *  @param picsArray 图片数组
 *  @param parameter 所需参数
 *  @param urlString url字符串
 *  @param success   上传成功回调
 *  @param failure   上传失败回调
 */
- (void)mutiPic:(NSArray<UIImage *> *)picsArray parameterDic:(NSDictionary *)parameter urlString:(NSString *)urlString success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError* error))failure;
@end
