//
//  ModelTableViewCell.h
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"
#import "SDAutoLayout.h"
#import <UIImageView+WebCache.h>

#define CELL_Width self.contentView.frame.size.width
#define margin 15

@interface ModelTableViewCell : UITableViewCell

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *timeLabel;
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *countLabel;
@property (nonatomic) UIView *lineView;
@property (nonatomic) UIImageView *showImageView1;
@property (nonatomic) UIImageView *showImageView2;
@property (nonatomic) UIImageView *showImageView3;

@property (nonatomic, strong) DynamicList *dynamicList;

+ (NSString *)identifierForModelAtRow:(DynamicList *)dynamicList;

@end
