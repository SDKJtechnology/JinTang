//
//  DataModel+Dynamic.m
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DataModel+Dynamic.h"

#import "DynamicActivityModel.h"
#import "DynamicConcernsModel.h"
#import "DynamicHotspotModel.h"

@implementation DataModel (Dynamic)

//获取动态关注数据
- (void)getDynamicConcernsDataWithID:(NSNumber *)ID success:(DataModelBlock)success failure:(DataModelBlock)failure
{
    NSString *url = @"http://192.168.0.110/Article/get_fw_list";
    NSDictionary *paramsDic = @{@"rows":@10,@"a_id":ID};
    
    NSURLSessionDataTask *dataTask = [self.manager POST:url parameters:paramsDic progress:^(NSProgress * uploadProgress) {
        
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
- (void)getHotspotDataWithDate:(NSString *)date success:(DataModelBlock)success failure:(DataModelBlock)failure
{
    NSString *url = @"http://192.168.0.110/Article/get_hot_list";
    NSDictionary *params = @{@"date":date,@"days":@20};
    
    [self.manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (success)
        {
            NSDictionary *dic = [responseObject mj_JSONObject];
//            NSLog(@"%@",dic);
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
    
}


- (void)getDynamicActivityDataWithID:(NSNumber *)ID success:(DataModelBlock)success failure:(DataModelBlock)failure
{
    NSString *url = @"http://192.168.0.110/Article/get_at_list";
    NSDictionary *params = @{@"r_id":ID,@"rows":@10};
    
    NSURLSessionDataTask *dataTask = [self.manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [responseObject mj_JSONObject];
        if (![dic[@"code"] integerValue]) {
//            NSLog(@"%@",dic);
            NSArray *array = [DynamicActivityModel mj_objectArrayWithKeyValuesArray:dic[@"result"]];
            success(array);
        }
        else
            success (nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"=========%@",error);
    }];
    
    [dataTask resume];
    [self gei];
}

- (void)gei
{
    NSString *url = @"http://e1q4925944.iask.in/database/TopNumber?pages=1";
    
    NSURLSessionDataTask *dataTask = [[AFHTTPSessionManager manager] POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject mj_JSONObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    [dataTask resume];
}

@end
