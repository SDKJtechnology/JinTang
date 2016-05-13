//
//  DynamicConcernsModel.m
//  金堂
//
//  Created by SDKJ on 16/4/29.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicConcernsModel.h"

@implementation DynamicConcernsModel

//指定属性数组元素为Image类
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"imagesUrl":[Image class]};
}

//与属性名对应的json数据名称
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"title":@"a_title",@"ID":@"a_id",@"createDate":@"a_createdate",@"name":@"a_uname",@"readNumber":@"a_see_num",@"replyNumber":@"a_rev_num",@"imagesUrl":@"img"};
}

@end

@implementation Image

//与属性名对应的json数据名称
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"imageUrl":@"ai_url"};
}

@end
