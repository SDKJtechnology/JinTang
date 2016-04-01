//
//  DynamicModel.h
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DynamicModel : NSObject
/**
 *  标题
 */
@property (nonatomic, strong) NSString *titleString;
/**
 *  发帖人昵称
 */
@property (nonatomic, strong) NSString *nameString;
/**
 *  发布时间
 */
@property (nonatomic, strong) NSString *timeString;
/**
 *  阅读人数
 */
@property (nonatomic, strong) NSString *countString;
/**
 *  图片链接
 */
@property (nonatomic, strong) NSString *imageUrl;
/**
 *  多图片数组<imageUrl>
 */
@property (nonatomic, strong) NSArray *imageArray;

@end
