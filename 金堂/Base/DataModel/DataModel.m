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

@end
