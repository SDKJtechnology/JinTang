//
//  SupportTarentoModel.h
//  金堂
//
//  Created by SDKJ on 16/4/25.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  点赞达人模型
 */
@interface SupportTarentoModel : NSObject
/**
 *  用户名
 */
@property (nonatomic, strong) NSString *userNameString;
/**
 *  详情
 */
@property (nonatomic, strong) NSString *detailString;
/**
 *  头像链接
 */
@property (nonatomic, strong) NSString *userImageUrl;
/**
 *  图片组
 */
@property (nonatomic, strong) NSArray *imagesArray;

@end
