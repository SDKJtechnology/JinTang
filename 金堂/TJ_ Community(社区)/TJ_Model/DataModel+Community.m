//
//  DataModel+Community.m
//  金堂
//
//  Created by SDKJ on 16/5/12.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DataModel+Community.h"

@implementation DataModel (Community)

- (void)getCommunityDataSuccess:(DataModelBlock)success failure:(DataModelBlock)failure
{
    NSString *url = @"http://192.168.0.110/Article/get_palte";
    
    NSURLSessionDataTask *dataTask = [self.manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [responseObject mj_JSONObject];
        if (![dic[@"code"] integerValue]) {
            NSLog(@"%@",dic);
            
        }
        else
            success (nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"=========%@",error);
    }];
    
    [dataTask resume];
}

@end
