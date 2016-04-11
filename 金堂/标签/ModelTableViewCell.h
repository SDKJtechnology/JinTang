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
#import "TJ_BAButton.h"
#import <UIImageView+WebCache.h>

#define CELL_Width self.contentView.frame.size.width
#define margin 10

@interface ModelTableViewCell : UITableViewCell
/**
 *  说说内容
 */
@property (nonatomic) UILabel *titleLabel;
/**
 *  发布地址
 */
@property (nonatomic) TJ_BACustomButton *addressButton;
/**
 *  发布时间
 */
@property (nonatomic) UILabel *timeLabel;
/**
 *  发布人昵称
 */
@property (nonatomic) TJ_BACustomButton *nameButton;

/**
 *  浏览人数
 */
@property (nonatomic) TJ_BACustomButton *browseCountButton;
/**
 *  浏览图标
 */
@property (nonatomic) UIImageView *browseImage;
/**
 *  点赞人数
 */
@property (nonatomic) TJ_BACustomButton *supportCountButton;
/**
 *  点赞图标
 */
@property (nonatomic) UIImageView *supportImageView;
/**
 *  回复数量
 */
@property (nonatomic) TJ_BACustomButton *replyCountButton;
/**
 *  回复图标
 */
@property (nonatomic) UIImageView *replyImageView;
/**
 *  头像图片
 */
@property (nonatomic, strong) TJ_BACustomButton *headerButton;
/**
 *  多图数组
 */
@property (nonatomic) NSArray *images;
@property (nonatomic) UIImageView *showImageView1;
@property (nonatomic) UIImageView *showImageView2;
@property (nonatomic) UIImageView *showImageView3;
@property (nonatomic) UIView *lineView;
/**
 *   数据模型
 */
@property (nonatomic, strong) DynamicList *dynamicList;

/**
 *  通过数据模型获得对应的cell类
 *
 *  @param dynamicList 数据模型
 *
 *  @return cell类名
 */
+ (NSString *)identifierForModelAtRow:(DynamicList *)dynamicList;

/**
 *  获取按钮titleLabel frame
 *
 *  @param button 按钮对象
 *
 *  @return 返回CGRect
 */
- (CGRect)getTitleLabelTexeFrame:(UIButton *)button;

//获取imageView的frame
- (CGRect)getImageViewFrame:(UIButton *)button;

@end
