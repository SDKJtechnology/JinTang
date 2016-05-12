//
//  TJ_ CalculateCache.h
//  金堂
//
//  Created by SDKJ on 16/4/22.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *   缓存处理
 */
@interface TJ_CalculateCache : NSObject

//类方法
+ (instancetype)sharedCalculateCache;

// 计算单个文件大小
- (float)getFileSizeAtPath:(NSString*)path;
// 计算目录大小
- (float)getFolderSizeAtPath:(NSString*)path;
// 清除文件
- (void)clearCache:(NSString *)path;

@end
