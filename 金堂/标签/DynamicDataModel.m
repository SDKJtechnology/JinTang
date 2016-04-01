//
//  DynamicDataModel.m
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicDataModel.h"
#import "AFNetworking.h"
#import "DynamicModel.h"
#import "XYString.h"
#import "MJExtension.h"

@implementation DynamicDataModel

+ (instancetype)sharedObejct
{
    static DynamicDataModel *dynamicDataModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dynamicDataModel = [[super allocWithZone:NULL] init];
    });
    
    return dynamicDataModel;
}

+ (void)getDynamicDataWithPage:(NSNumber *)page
{
    NSString *url = @"http://xc163.qianfanapi.com/v1_4/home/index";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *paramsDic = @{@"params":@{@"page":page}};

    NSURLSessionDataTask *dataTask = [manager POST:url parameters:paramsDic progress:^(NSProgress * uploadProgress) {
        
    } success:^(NSURLSessionDataTask * task, id responseObject) {
        NSString *jsonString = [XYString getJsonStringFromObject:responseObject];
        NSDictionary *dict = [XYString getObjectFromJsonString:jsonString];
        
        //..keyEnumerator 获取字典里面所有键  objectEnumerator得到里面的对象  keyEnumerator得到里面的键值
//        NSString *key = [dict.keyEnumerator nextObject];//.取键值
        NSArray *temArray = dict[@"data"];
        
        // 数组>>model数组
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:[DynamicModel mj_objectArrayWithKeyValuesArray:temArray]];
        
        NSDictionary *dataDic = [responseObject objectForKey:@"data"];
        NSArray *listArray = [dataDic objectForKey:@"list"];
        NSMutableArray *dynamicDataArray = [NSMutableArray array];
        for (NSDictionary *dict in listArray) {
            DynamicModel *dynamic = [DynamicModel new];
            dynamic.titleString = [dict objectForKey:@"title"];
            dynamic.timeString = [dict objectForKey:@"push_at"];
            dynamic.nameString = [dict objectForKey:@"author"];
            dynamic.countString = [dict objectForKey:@"views_num"];
        }
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        
    }];
    
    [dataTask resume];
}

@end
