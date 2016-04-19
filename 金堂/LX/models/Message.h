//
//  Message.h
//  金堂
//
//  Created by zouxin on 16/4/13.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
//聊天内容
@property(nonatomic,strong) NSString *content;

//内容是发还是收
@property(nonatomic) BOOL fromMe;

+(NSArray *)demoData;

@end
