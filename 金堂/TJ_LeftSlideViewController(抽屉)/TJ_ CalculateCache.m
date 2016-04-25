//
//  TJ_ CalculateCache.m
//  金堂
//
//  Created by SDKJ on 16/4/22.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_ CalculateCache.h"

@implementation TJ_CalculateCache

//单利
+ (instancetype)sharedCalculateCache
{
    static TJ_CalculateCache *calculateFileSize =nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calculateFileSize = [[super allocWithZone:NULL] init];
    });
    
    return calculateFileSize;
}

//计算单个文件大小返回值是M
- (float)getFileSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:path]){
        
        NSUInteger size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        // 返回值是字节 B K M
        
        return size/1024.0/1024.0;
        
    }
    
    return 0;
}

//计算目录大小
- (float)getFolderSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    float folderSize;
    
    if ([fileManager fileExistsAtPath:path]) {
        
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        
        for (NSString *fileName in childerFiles) {
            
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            
            // 计算单个文件大小
            folderSize += [self getFileSizeAtPath:absolutePath];
            
        }
        
        return folderSize;
    }
    return 0;
}

//清理缓存文件
- (void)clearCache:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        
        for (NSString *fileName in childerFiles) {
            
            //如有需要，加入条件，过滤掉不想删除的文件
            
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}

@end
