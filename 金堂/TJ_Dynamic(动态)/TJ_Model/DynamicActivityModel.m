//
//  DynamicActivityModel.m
//  金堂
//
//  Created by SDKJ on 16/4/29.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicActivityModel.h"

@implementation DynamicActivityModel

//与属性名对应的json数据名称
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"startDate":@"a_start_date",@"endDate":@"a_end_date",@"title":@"a_title",@"ID":@"a_id",@"createDate":@"a_createdate",@"image_Url":@"a_img_url"};
}

@end
