//
//  TJ_TableViewCellModel.h
//  金堂
//
//  Created by SDKJ on 16/4/15.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJ_BAButton.h"
#import "SDAutoLayout.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "TJ_SharedPhotoView.h"
#import "MLLinkLabel.h"
#import "MolonDebug.h"
#define CELL_Width self.contentView.frame.size.width
#define margin 10

@interface TJ_TableViewCellModel : UITableViewCell<MLLinkLabelDelegate>

/**
 *  说说内容
 */
@property (nonatomic) MLLinkLabel *titleLabel;
/**
 *  发布地址
 */
@property (nonatomic) TJ_BACustomButton *rightButton;

@property (nonatomic) UILabel *addressLabel;
/**
 *  发布时间
 */
@property (nonatomic) UILabel *timeLabel;
/**
 *  性别图
 */
@property (nonatomic) UIImageView *sexImageView;
/**
 *  发布人昵称
 */
@property (nonatomic) TJ_BACustomButton *nameButton;

/**
 *  浏览人数
 */
@property (nonatomic) TJ_BACustomButton *browseCountButton;
/**
 *  点赞人数
 */
@property (nonatomic) TJ_BACustomButton *supportCountButton;
/**
 *  分享按钮
 */
@property (nonatomic, strong) TJ_BACustomButton *shareButton;
/**
 *  回复数量
 */
@property (nonatomic) TJ_BACustomButton *replyCountButton;
/**
 *  头像图片
 */
@property (nonatomic, strong) TJ_BACustomButton *headerButton;
/**
 *  照片分享视图
 */
@property (nonatomic) TJ__SharedPhotoView *sharedPhotoView;

+ (NSString *)identifierForModelAtRow:(id)Model;

@end
