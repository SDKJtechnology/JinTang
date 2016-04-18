//
//  HotCollectionViewCell.h
//  金堂
//
//  Created by SDKJ on 16/4/14.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJ_BAButton.h"

@interface TJ_HotCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIImageView *backgroundImage;//背景试图

@property (nonatomic) UILabel *titleLabel;//标题label

@property (nonatomic) UILabel *contentLabel;//内容label

@property (nonatomic) TJ_BACustomButton *nameButton;//昵称按钮

@property (nonatomic) TJ_BACustomButton *supportButton;//点赞按钮

@end
