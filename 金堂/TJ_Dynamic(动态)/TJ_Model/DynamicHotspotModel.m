//
//  DynamicHotspotModel.m
//  金堂
//
//  Created by SDKJ on 16/4/29.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicHotspotModel.h"

@implementation DynamicHotspotModel

//与属性名对应的json数据名称
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"title":@"a_title",@"ID":@"a_id",@"createDate":@"days",@"image_url":@"img"};
}
@end
