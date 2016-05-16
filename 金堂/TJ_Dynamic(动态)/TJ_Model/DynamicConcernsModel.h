//
//  DynamicConcernsModel.h
//  金堂
//
//  Created by SDKJ on 16/4/29.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface DynamicConcernsModel : NSObject
/**
 *  帖子ID
 */
@property (nonatomic, strong) NSNumber *ID;
/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  发帖人昵称
 */
@property (nonatomic, strong) NSString *name;
/**
 *  阅读人数
 */
@property (nonatomic, strong) NSString *readNumber;
/**
 *  回复人数
 */
@property (nonatomic, strong) NSString *replyNumber;
/**
 *  发布时间
 */
@property (nonatomic, strong) NSString *createDate;
/**
 *  多图片数组<Image>
 */
@property (nonatomic, strong) NSArray *imagesUrl;
/**
 *  单张图片地址
 */
@property (nonatomic, strong) NSString *image_url;

@end

@interface Image : NSObject

@property (nonatomic, strong) NSString *imageUrl;

@end
