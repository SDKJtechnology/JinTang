//
//  HotspotModel.h
//  金堂
//
//  Created by ZhangAnMing on 16/4/10.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Body : NSObject
/**
 *   热点标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  热点图片
 */
@property (nonatomic, strong) NSString *imageUrl;

@end
/**
 *  热点项目类
 */
@interface Item : NSObject
/**
 *  当日热点头条字典数据
 */
@property (nonatomic, strong) NSDictionary *headerDict;
/**
 *  当日其他热点项数组（Body）
 */
@property (nonatomic, strong) NSArray *body;
/**
 *  当日热点头条
 */
@property (nonatomic, strong) Body *header;

@end
/**
 *  热点模型类
 */
@interface ActivityModel : NSObject
/**
 *  发布时间
 */
@property (nonatomic, strong) NSString *pushtime;
/**
 *  热点项目
 */
@property (nonatomic, strong) Item *item;
/**
 *  热点项字典数据
 */
@property (nonatomic, strong) NSDictionary *items;

@end


