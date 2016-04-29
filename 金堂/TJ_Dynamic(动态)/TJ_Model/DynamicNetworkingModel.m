//
//  DynamicDataModel.m
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicNetworkingModel.h"
#import "AFNetworking.h"
#import "DynamicModel.h"
#import "XYString.h"
#import "MJExtension.h"
#import "ActivityModel.h"
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
    NSDictionary *paramsDic = @{@"rows":@20,@"a_id":@0};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager POST:url parameters:paramsDic progress:^(NSProgress * uploadProgress) {
        
    } success:^(NSURLSessionDataTask * task, id responseObject) {
        if (success)
        {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray *array = [DynamicConcernsModel mj_objectArrayWithKeyValuesArray:dic[@"result"]];
            
            success(array);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        if (failure) {
            failure(error);
        }
    }];
    
    [dataTask resume];
}

//获取动态热点数据
- (void)getHotspotDataWithPage:(NSNumber *)page success:(DynamicNetworkingBlock)success failure:(DynamicNetworkingBlock)failure
{
    NSString *url = @"http://192.168.0.110/Article/get_hot_list";
    NSDictionary *params = @{@"a_id":@0,@"rows":@20};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog( @"%@",[responseObject mj_JSONString]);
        if (success)
        {
//            NSArray *array = [DynamicHotspotModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
//            success(array);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    [dataTask resume];
    [self getHotspotDataWithPage1111];
}


- (void)getHotspotDataWithPage1111
{
    NSString *url = @"http://192.168.0.110/Article/get_my_rev";
    NSDictionary *params = @{@"r_id":@5,@"rows":@2};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"=========%@",error);
    }];
    
    [dataTask resume];
}


@end
