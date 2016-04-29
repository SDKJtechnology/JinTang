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
 *  发布时间
 */
@property (nonatomic, strong) NSString *createDate;
/**
 *  多图片数组<Image>
 */
@property (nonatomic, strong) NSArray *imagesUrl;

@end

@interface Image : NSObject

@property (nonatomic, strong) NSString *imageUrl;

@end
