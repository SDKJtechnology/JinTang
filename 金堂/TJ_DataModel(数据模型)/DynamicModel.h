//
//  DynamicModel.h
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  动态模型
 */
@interface DynamicList : NSObject
/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  发帖人昵称
 */
@property (nonatomic, strong) NSString *source;
/**
 *  阅读人数
 */
@property (nonatomic, strong) NSString *views_num;
/**
 *  发布时间
 */
@property (nonatomic, strong) NSString *push_at;
/**
 *  多图片数组<AttachesImage>
 */
@property (nonatomic, strong) NSArray *attaches;

@end

/**
 *  关注数据类
 */
@interface DynamicData : NSObject

@property (nonatomic, strong) NSNumber *last_side_id;
@property (nonatomic, strong) NSNumber *last_post_id;
@property (nonatomic, strong) NSNumber *update_num;
@property (nonatomic, strong) NSNumber *has_unread_hot;
/**
 *  关注列表数组<DynamicList>
 */
@property (nonatomic, strong) NSArray *list;

@end
/**
 *  关注类模型
 */
@interface DynamicModel : NSObject

@property (nonatomic, strong) NSString *ret;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) DynamicData *data;

@end
