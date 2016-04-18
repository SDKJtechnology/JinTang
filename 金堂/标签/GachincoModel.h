//
//  GachincoModel.h
//  金堂
//
//  Created by ZhangAnMing on 16/4/16.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GachincoModel : NSObject

@property (nonatomic, strong) NSString *titleString;

@property (nonatomic, strong) NSArray *sharedImageUrls;

@property (nonatomic, strong) NSString *headImageUrl;

@property (nonatomic, strong) NSString *addressesSting;
/**
 *  发帖人昵称
 */
@property (nonatomic, strong) NSString *sourceName;

/**
 *  发布时间
 */
@property (nonatomic, strong) NSString *timeString;

- (instancetype)init:(NSInteger)i;

@end
