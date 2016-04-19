//
//  Message.m
//  金堂
//
//  Created by zouxin on 16/4/13.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "Message.h"

@implementation Message
+(NSArray *)demoData{
    Message *m1 = [Message new];
    m1.content = @"Hi";
    m1.fromMe = YES;
    
    Message *m2 = [Message new];
    m2.content = @"恩?什么事?";
    m2.fromMe = NO;
    
    Message *m3 = [Message new];
    m3.content = @"听说每逢佳节胖三斤,你怎么样？";
    m3.fromMe = YES;
    
    Message *m4 = [Message new];
    m4.content = @"哎,我国庆前节食了5天,国庆吃了顿全家桶，你懂的";
    m4.fromMe = NO;
    
    Message *m5 = [Message new];
    m5.content = @"听过你去买iphone6s了？能买到么，据说都是要预约的呢。要是你真想买的话，不如买个移动或者联通活动的吧，官网预定可能要1个月时间呢";
    m5.fromMe = YES;
    
    Message *m6 = [Message new];
    m6.content = @"恩恩,我的目标是找个200斤的帅哥。好吧，我想静静，不要问我静静是谁。打这么多字只是想验证下自动适配~~~";
    m6.fromMe = NO;
    return @[m1,m2,m3,m4,m5,m6];}
@end
