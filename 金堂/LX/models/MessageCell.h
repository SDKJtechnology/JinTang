//
//  MessageCell.h
//  金堂
//
//  Created by zouxin on 16/4/13.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
@interface MessageCell : UITableViewCell
//数据项
@property(nonatomic,strong) Message *message;
//泡泡图
@property(nonatomic,strong) UIImageView *popIV;
//内容标签
@property(nonatomic,strong) UILabel *contentLb;
//用于记录当前Cell需要多高才能显示全所有内容
@property(nonatomic) CGFloat cellHeight;
@end
