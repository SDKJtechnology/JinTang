//
//  DataModel+LefiSlide.m
//  金堂
//
//  Created by SDKJ on 16/5/12.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DataModel+LefiSlide.h"
#import "DynamicConcernsModel.h"

@implementation DataModel (LefiSlide)
//获取我的帖子列表数据
- (void)getPostingInvitationDataWithID:(NSNumber *)ID success:(DataModelBlock)success failure:(DataModelBlock)failure
{
    NSString *url = @"http://192.168.0.110/Article/get_my_rel";
    NSString *parameter = [NSString stringWithFormat:@"r_id:%@,rows:20",ID];
    
    NSURLSessionDataTask *dataTask = [self.manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [responseObject mj_JSONObject];

        if (![dic[@"code"] integerValue]) {
            //            NSLog(@"%@",dic);
            NSDictionary *dic = [responseObject mj_JSONObject];
            NSArray *array = [DynamicConcernsModel mj_objectArrayWithKeyValuesArray:dic[@"result"]];
            success(array);
        }
        else if([dic[@"code"] integerValue] == -10){
            success (nil);
            NSLog(@"%@",dic[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"getPostingInvitationDataWithID");
        failure(error);
    }];
    
    [dataTask resume];
}
//获取我回复的帖子列表数据
- (void)getReturnInvitationDataWithID:(NSNumber *)ID success:(DataModelBlock)success failure:(DataModelBlock)failure
{
    NSString *url = @"http://192.168.0.110/Article/get_my_rev";
    NSString *parameter = [NSString stringWithFormat:@"r_id:%@,rows:20",ID];
    
    NSURLSessionDataTask *dataTask = [self.manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [responseObject mj_JSONObject];
        if (![dic[@"code"] integerValue]) {
//            NSLog(@"%@",dic);
            NSDictionary *dic = [responseObject mj_JSONObject];
            NSArray *array = [DynamicConcernsModel mj_objectArrayWithKeyValuesArray:dic[@"result"]];
            success(array);
        }
        else if([dic[@"code"] integerValue] == -10){
            success (nil);
            NSLog(@"%@",dic[@"msg"]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"=========%@",error);
        failure(error);
    }];
    
    [dataTask resume];
}

//获取我收藏的帖子列表数据
- (void)getEnshrineInvitationDataWithID:(NSNumber *)ID success:(DataModelBlock)success failure:(DataModelBlock)failure
{
    NSString *url = @"http://192.168.0.110/Article/get_my_rev";
    NSString *parameter = [NSString stringWithFormat:@"r_id:%@,rows:20",ID];
    
    NSURLSessionDataTask *dataTask = [self.manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [responseObject mj_JSONObject];
        if (![dic[@"code"] integerValue]) {
            //            NSLog(@"%@",dic);
            NSDictionary *dic = [responseObject mj_JSONObject];
            NSArray *array = [DynamicConcernsModel mj_objectArrayWithKeyValuesArray:dic[@"result"]];
            success(array);
        }
        else if([dic[@"code"] integerValue] == -10){
            success (nil);
            NSLog(@"%@",dic[@"msg"]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"=========%@",error);
        failure(error);
    }];
    
    [dataTask resume];
}

@end
