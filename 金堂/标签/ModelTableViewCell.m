//
//  ModelTableViewCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "ModelTableViewCell.h"
#import "UILabel+new.h"

@implementation ModelTableViewCell

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
        self.timeLabel.textColor = [UIColor colorWithWhite:0.613 alpha:1.000];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.timeLabel];
        
        //发布地点
        self.addressButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusRight];
        [self.addressButton setTitleColor:[UIColor colorWithRed:0.175 green:1.000 blue:0.533 alpha:1.000] forState:UIControlStateNormal];
        self.addressButton.titleLabel.font = self.titleLabel.font;
        [self.contentView addSubview:self.addressButton];
        
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
    
    self.replyCountButton.sd_layout
    .topSpaceToView(self.titleLabel, margin)
    .rightEqualToView(self.addressButton)
    .heightIs(20);
    
    self.supportCountButton.sd_layout
    .topSpaceToView(self.titleLabel, margin)
    .rightSpaceToView(self.replyCountButton, margin)
    .heightIs(20);
    
    self.browseCountButton.sd_layout
    .topSpaceToView(self.titleLabel, margin)
    .rightSpaceToView(self.supportCountButton, margin)
    .heightIs(20);
    
    [self setupAutoHeightWithBottomViewsArray:@[self.replyCountButton, self.supportCountButton, self.browseCountButton] bottomMargin:margin / 2];
}

+ (NSString *)identifierForModelAtRow:(DynamicList *)dynamicList
{
    switch (dynamicList.attaches.count) {
        case 5:
            return @"DynamicOneImageCell";
            break;
        case 4:
            return @"DynamicThreeImageCell";
            break;
        default:
            return @"DynamicNotImageCell";
            break;
    }
}

//获取按钮titleLabel大小
- (CGRect)getTitleLabelTexeFrame:(UIButton *)button
{
    CGRect frame = [button.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:button.titleLabel.font} context:nil];
    return frame;
}
//获取imageView的frame
- (CGRect)getImageViewFrame:(UIButton *)button
{
    return button.imageView.frame;
}

@end
