//
//  ModelTableViewCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicConcernNotImageCell.h"
#import "UILabel+new.h"
#import "TJ_SharedPhotoView.h"

@interface DynamicConcernNotImageCell()
{
//    TJ__SharedPhotoView *sharedPhotoView;
}

@end

@implementation DynamicConcernNotImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //说说内容label
        self.titleLabel = [UILabel new];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.numberOfLines = 0;
        
        //发布人昵称
        self.nameButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusLeft];
        self.nameButton.titleLabel.font = self.titleLabel.font;
        [self.nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.nameButton];

        //发布人头像
        self.headerButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusNormal];
        [self.contentView addSubview:self.headerButton];
        
        //发布时间label
        self.timeLabel = [UILabel new];
        self.timeLabel.textColor = [UIColor colorWithWhite:0.483 alpha:1.000];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.timeLabel];
        
        //发布地点
        self.addressButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusRight];
        [self.addressButton setTitleColor:[UIColor colorWithRed:0.175 green:1.000 blue:0.533 alpha:1.000] forState:UIControlStateNormal];
        self.addressButton.titleLabel.font = self.titleLabel.font;
        [self.contentView addSubview:self.addressButton];
        
        //分享照片视图
        sharedPhotoView = [TJ__SharedPhotoView new];
        [self.contentView addSubview:sharedPhotoView];
        
        
        // 浏览人数label
        self.browseCountButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusNormal];
        [self.browseCountButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.browseCountButton];

        //点赞人数
        self.supportCountButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusNormal];
        [self.supportCountButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.supportCountButton];

        //回复人数
        self.replyCountButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusNormal];
        [self.replyCountButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.replyCountButton];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.headerButton.sd_layout
    .topSpaceToView(self.contentView, margin)
    .leftSpaceToView(self.contentView, margin)
    .widthIs(40)
    .heightEqualToWidth();
    
    self.nameButton.sd_layout
    .topEqualToView(self.headerButton)
    .leftSpaceToView(self.headerButton, margin / 2)
    .minWidthIs(100)
    .heightIs(self.headerButton.height / 2);
    [self.nameButton.titleLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.timeLabel.sd_layout
    .leftEqualToView(self.nameButton)
    .topSpaceToView(self.nameButton, margin / 3)
    .autoHeightRatio(0);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.addressButton.sd_layout
    .topEqualToView(self.headerButton)
    .rightSpaceToView(self.contentView, margin)
    .heightRatioToView(self.nameButton, 1);
    
    UILabel *addressLabel = [UILabel new];
    [self.contentView addSubview:addressLabel];
    addressLabel.font = self.addressButton.titleLabel.font;
    addressLabel.textColor = [UIColor grayColor];
    addressLabel.text = @"来自";
    addressLabel.font = self.nameButton.titleLabel.font;
    addressLabel.sd_layout
    .topEqualToView(self.nameButton)
    .heightRatioToView(self.nameButton, 1)
    .rightSpaceToView(self.addressButton, 0);
    [addressLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.titleLabel.sd_layout
    .topSpaceToView(self.headerButton, margin / 2)
    .leftEqualToView(self.headerButton)
    .rightSpaceToView(self.contentView, margin)
    .autoHeightRatio(0);
    
    sharedPhotoView.sd_layout
    .topSpaceToView(self.titleLabel, margin)
    .leftEqualToView(self.titleLabel);
    
    self.replyCountButton.sd_layout
    .topSpaceToView(self.titleLabel, margin / 2)
    .rightEqualToView(self.titleLabel)
    .widthIs(150)
    .heightIs(20);
    
    self.supportCountButton.sd_layout
    .topEqualToView(self.replyCountButton)
    .rightSpaceToView(self.replyCountButton, margin)
    .widthIs(150)
    .heightIs(20);
    
    self.browseCountButton.sd_layout
    .topEqualToView(self.replyCountButton)
    .rightSpaceToView(self.supportCountButton, margin)
    .widthIs(150)
    .heightIs(20);
    
    [self setupAutoHeightWithBottomView:self.browseCountButton bottomMargin:margin / 2];
}

//获取按钮titleLabel大小
- (CGRect)getTitleLabelTexeFrame:(TJ_BACustomButton *)button
{
    CGRect frame = [button.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:button.titleLabel.font} context:nil];
    return frame;
}

//获取imageView的frame
- (CGRect)getImageViewFrame:(TJ_BACustomButton *)button
{
    return button.imageView.frame;
}

- (void)setDynamicList:(DynamicList *)dynamicList
{
    [self.headerButton setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    
    self.titleLabel.text = dynamicList.title;
    
    [self.nameButton setTitle:dynamicList.source forState:UIControlStateNormal];
    [self.nameButton setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
    
    self.timeLabel.text = dynamicList.push_at;
    
    [self.addressButton setTitle:@"金堂印象" forState:UIControlStateNormal];
    CGRect frame = [self getTitleLabelTexeFrame:self.addressButton];
    self.addressButton.sd_layout.widthIs(frame.size.width);
    
    [self.replyCountButton setImage:[UIImage imageNamed:@"lun"] forState:UIControlStateNormal];
    [self.replyCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.replyCountButton.sd_layout.widthIs([self.replyCountButton getTitleLabelWith].size.width + [self.replyCountButton getImageViewFrame].size.width);
    
    [self.supportCountButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self.supportCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.supportCountButton.sd_layout.widthIs([self.supportCountButton getImageViewFrame].size.width + [self.supportCountButton getTitleLabelWith].size.width);
    
    [self.browseCountButton setImage:[UIImage imageNamed:@"kan"] forState:UIControlStateNormal];
    [self.browseCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.browseCountButton.sd_layout.widthIs([self.browseCountButton getImageViewFrame].size.width + [self.browseCountButton getTitleLabelWith].size.width);
}

+ (NSString *)identifierForModelAtRow:(DynamicList *)dynamicList
{
    switch (dynamicList.attaches.count) {
        case 3:
            return @"DynamicConcernManyImageCell";
            break;
        case 1:
            return @"DynamicConcernOneImageCell";
            break;
        default:
            return @"DynamicConcernNotImageCell";
            break;
    }
}

@end

@implementation DynamicConcernOneImageCell

- (void)setDynamicList:(DynamicList *)dynamicList
{
    self.replyCountButton.sd_layout.topSpaceToView(sharedPhotoView, margin / 2);
    sharedPhotoView.imageUrlArray = dynamicList.attaches;
    
    [self.headerButton setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    
    self.titleLabel.text = dynamicList.title;
    
    [self.nameButton setTitle:dynamicList.source forState:UIControlStateNormal];
    [self.nameButton setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
    
    self.timeLabel.text = dynamicList.push_at;
    
    [self.replyCountButton setImage:[UIImage imageNamed:@"lun"] forState:UIControlStateNormal];
    [self.replyCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.replyCountButton.sd_layout.widthIs([self.replyCountButton getTitleLabelWith].size.width + [self.replyCountButton getImageViewFrame].size.width);
    
    [self.supportCountButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self.supportCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.supportCountButton.sd_layout.widthIs([self.supportCountButton getImageViewFrame].size.width + [self.supportCountButton getTitleLabelWith].size.width);
    
    [self.browseCountButton setImage:[UIImage imageNamed:@"kan"] forState:UIControlStateNormal];
    [self.browseCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.browseCountButton.sd_layout.widthIs([self.browseCountButton getImageViewFrame].size.width + [self.browseCountButton getTitleLabelWith].size.width);
}

@end

@implementation DynamicConcernManyImageCell

- (void)setDynamicList:(DynamicList *)dynamicList
{
    self.replyCountButton.sd_layout.topSpaceToView(sharedPhotoView, margin / 2);

    [self.headerButton setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    
    self.titleLabel.text = dynamicList.title;
    
    [self.nameButton setTitle:dynamicList.source forState:UIControlStateNormal];
    [self.nameButton setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
    
    self.timeLabel.text = dynamicList.push_at;
    
    [self.addressButton setTitle:@"金堂印象" forState:UIControlStateNormal];
    CGRect frame = [self getTitleLabelTexeFrame:self.addressButton];
    self.addressButton.sd_layout.widthIs(frame.size.width);
    
    [self.replyCountButton setImage:[UIImage imageNamed:@"lun"] forState:UIControlStateNormal];
    [self.replyCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.replyCountButton.sd_layout.widthIs([self.replyCountButton getTitleLabelWith].size.width + [self.replyCountButton getImageViewFrame].size.width);
    
    [self.supportCountButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self.supportCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.supportCountButton.sd_layout.widthIs([self.supportCountButton getImageViewFrame].size.width + [self.supportCountButton getTitleLabelWith].size.width);
    
    [self.browseCountButton setImage:[UIImage imageNamed:@"kan"] forState:UIControlStateNormal];
    [self.browseCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.browseCountButton.sd_layout.widthIs([self.browseCountButton getImageViewFrame].size.width + [self.browseCountButton getTitleLabelWith].size.width);
    
    sharedPhotoView.imageUrlArray = dynamicList.attaches;
}

@end
