//
//  HotspotModel.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/10.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "HotspotModel.h"
#import "MJExtension.h"


@implementation HotspotModel

@end

@implementation Item
//指定属性body数组元素为Body类
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"body":@"Body"};
}
//属性headerDict对应的json数据名
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"headerDict":@"header"};
}

@end

@implementation Body
//与属性名对应的json数据名称
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"title":@"new_title",@"imageUrl":@"cover"};
}

@end
