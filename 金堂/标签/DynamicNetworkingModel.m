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

- (void)getDynamicDataWithPage:(NSNumber *)page
{
    NSString *url = @"http://xc163.qianfanapi.com/v1_4/home/index";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *paramsDic = @{@"params":@{@"page":page}};

    NSURLSessionDataTask *dataTask = [manager POST:url parameters:paramsDic progress:^(NSProgress * uploadProgress) {
        
    } success:^(NSURLSessionDataTask * task, id responseObject) {
        if (self.dynamicListBlock) {
//            NSLog(@"%@",responseObject);
            NSArray *array = [DynamicModel mj_objectWithKeyValues:responseObject].data.list;
            NSMutableArray *imageAr ;
            for (DynamicList *list in array) {
                imageAr = [NSMutableArray array];
                for (NSDictionary *dic in list.attaches) {
                    [imageAr addObject:[dic objectForKey:@"attachurl"]];
                }
                list.attaches = imageAr;
            }
            self.dynamicListBlock(array);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        
    }];
    
    [dataTask resume];
}

@end
