//
//  DataModel.m
//  金堂
//
//  Created by SDKJ on 16/5/12.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel
+ (instancetype)sharedObejct
{
    static DataModel *dataModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataModel = [[super allocWithZone:NULL] init];
    });
    
    return dataModel;
}

- (AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //重要 序列化格式 自动
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //设置 可访问未经通过的证书网站
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    return manager;
}

- (void)mutiPic:(NSArray *)picsArray parameterDic:(NSDictionary *)parameter urlString:(NSString *)urlString success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError* error))failure{
    
    [self.manager POST:urlString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 上传文件 有传闻说，每次上传的文件名不能一致，否则会有问题。所以直接用时间命名了。后台那边也会对拿到的pic做重命名，所以名字没有意义
        for (int i = 0; i<[picsArray count]; i++) {
            UIImage *image = [picsArray objectAtIndex:i];
            NSData *imageData = UIImagePNGRepresentation(image);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *_fileName = [NSString stringWithFormat:@"%@%d.png", str,i];
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"image_%d",i] fileName:_fileName mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:failure];
}

@end
