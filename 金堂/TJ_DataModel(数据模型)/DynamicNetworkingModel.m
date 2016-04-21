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

//获取动态数据
- (void)getDynamicDataWithPage:(NSNumber *)page success:(DynamicNetworkingBlock)success failure:(DynamicNetworkingBlock)failure
{
    NSString *url = @"http://xc163.qianfanapi.com/v1_4/home/index";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *paramsDic = @{@"params":@{@"page":page}};

    NSURLSessionDataTask *dataTask = [manager POST:url parameters:paramsDic progress:^(NSProgress * uploadProgress) {
        
    } success:^(NSURLSessionDataTask * task, id responseObject) {
        if (success)
        {
            NSLog(@"%@",responseObject);
            NSArray *array = [DynamicModel mj_objectWithKeyValues:responseObject].data.list;
            NSMutableArray *imageAr ;
            for (DynamicList *list in array)
            {
                imageAr = [NSMutableArray array];
                for (NSDictionary *dic in list.attaches) {
                    [imageAr addObject:[dic objectForKey:@"attachurl"]];
                }
                list.attaches = imageAr;
            }
            success(array);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        if (failure) {
            failure(error);
        }
    }];
    
    [dataTask resume];
}

//获取热点数据
- (void)getHotspotDataWithPage:(NSNumber *)page success:(DynamicNetworkingBlock)success failure:(DynamicNetworkingBlock)failure
{
    NSString *url = @"http://xc163.qianfanapi.com/v1_4/home/get-recommend";
    NSDictionary *params = @{@"params":@{@"page":page}};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *dataTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog( @"%@",responseObject);
        if (success)
        {
            NSArray *array = [ActivityModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (ActivityModel *hot in array) {
                hot.item = [Item mj_objectWithKeyValues:hot.items];
                hot.item.header = [Body mj_objectWithKeyValues:hot.item.headerDict];
            }
    //        self.hotspotDataBlock(array);
        
            success(array);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    [dataTask resume];
}

@end
