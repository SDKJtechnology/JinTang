//
//  TJ_Emoji.h
//  金堂
//
//  Created by SDKJ on 16/5/5.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJ_Emoji : NSObject
/**
 *  获取表情字典
 *
 *  @return 表情名称、图片名称键值对
 */
+ (NSDictionary *)getEmojiDictionary;
/**
 *  获取表情名称数组
 *
 *  @return 表情名称
 */
+ (NSArray *)getEmojiArray;

@end
