//
//  DynamicDataModel.m
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicNetworkingModel.h"
#import "AFNetworking.h"
#import "XYString.h"
#import "MJExtension.h"
#import "DynamicActivityModel.h"
#import "NSDictionary Chinese.h"
#import "DynamicConcernsModel.h"
#import "DynamicHotspotModel.h"

@implementation DynamicNetworkingModel

+ (instancetype)sharedObejct
{
    static DynamicNetworkingModel *dynamicDataModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dynamicDataModel = [[super allocWithZone:NULL] init];
    });
    
    return dynamicDataModel;
}

//获取动态关注数据
- (void)getDynamicConcernsDataWithID:(NSNumber *)ID success:(DynamicNetworkingBlock)success failure:(DynamicNetworkingBlock)failure
{
    NSString *url = @"http://192.168.0.110/Article/get_fw_list";
    NSDictionary *paramsDic = @{@"rows":@10,@"a_id":ID};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager POST:url parameters:paramsDic progress:^(NSProgress * uploadProgress) {
        
    } success:^(NSURLSessionDataTask * task, id responseObject) {
        if (success)
        {
            NSDictionary *dic = [responseObject mj_JSONObject];
            if (![dic[@"code"] intValue]) {
                NSArray *array = [DynamicConcernsModel mj_objectArrayWithKeyValuesArray:dic[@"result"]];
            
                success(array);
            }
            else
                success(nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        if (failure) {
            failure(error);
        }
    }];
    
    [dataTask resume];
}

//获取动态热点数据
- (void)getHotspotDataWithDate:(NSString *)date success:(DynamicNetworkingBlock)success failure:(DynamicNetworkingBlock)failure
{
    NSString *url = @"http://192.168.0.110/Article/get_hot_list";
    NSDictionary *params = @{@"date":date,@"days":@20};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (success)
        {
            NSDictionary *dic = [responseObject mj_JSONObject];
            if (![dic[@"code"] intValue]) {
                NSArray *array = [DynamicHotspotModel mj_objectArrayWithKeyValuesArray:dic[@"result"]];
                NSInteger i = 0;
                NSMutableArray *newArray = [NSMutableArray array];
                while (i < array.count) {
                    DynamicHotspotModel *model1 = array[i];
                    NSMutableArray *ar = [NSMutableArray array];
                    for (NSInteger j = i; j < array.count; j++) {
                        DynamicHotspotModel *model = array[j];
                        if ([model.createDate isEqual:model1.createDate]) {
                            [ar addObject:model];
                            i = j + 1;
                        }
                    }
                    [newArray addObject:ar];
                }
                success(newArray);
            }
            else
                success(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    [dataTask resume];
}


- (void)getDynamicActivityDataWithID:(NSNumber *)ID success:(DynamicNetworkingBlock)success failure:(DynamicNetworkingBlock)failure
{
    NSString *url = @"http://192.168.0.110/Article/get_at_list";
    NSDictionary *params = @{@"r_id":@5,@"rows":@2};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [responseObject mj_JSONObject];
        if (![dic[@"code"] integerValue]) {
            NSLog(@"%@",dic);
            NSArray *array = [DynamicActivityModel mj_objectArrayWithKeyValuesArray:dic[@"result"]];
            success(array);
        }
        else
            success (nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"=========%@",error);
    }];
    
    [dataTask resume];
}


@end
