//
//  DynamicTwoImageCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicThreeImageCell.h"

@implementation DynamicThreeImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat miniWidth = 50;
        
        self.titleLabel.sd_layout
        .topSpaceToView(self.contentView, margin)
        .leftSpaceToView(self.contentView, margin)
        .rightSpaceToView(self.contentView, margin)
        .autoHeightRatio(0);
        
        self.showImageView1.sd_layout
        .autoHeightRatio(0.7)
        .leftSpaceToView(self.contentView, margin)
        .topSpaceToView(self.titleLabel, margin);
        
        self.showImageView2.sd_layout
        .autoHeightRatio(0.7)
        .leftSpaceToView(self.showImageView1, margin)
        .topSpaceToView(self.titleLabel, margin);
        
        self.showImageView3.sd_layout
        .autoHeightRatio(0.7)
        .leftSpaceToView(self.showImageView2, margin)
        .topSpaceToView(self.titleLabel, margin)
        .rightSpaceToView(self.contentView, margin);
        
        self.nameLabel.sd_layout
        .leftSpaceToView(self.contentView, margin)
        .topSpaceToView(self.showImageView1, margin)
        .autoHeightRatio(0)
        .minWidthIs(miniWidth / 2);
        [self.nameLabel setSingleLineAutoResizeWithMaxWidth:CELL_Width / 3];
        
        self.countLabel.sd_layout
        .leftSpaceToView(self.nameLabel, margin)
        .topSpaceToView(self.showImageView1, margin)
        .autoHeightRatio(0)
        .minWidthIs(miniWidth);
        [self.countLabel setSingleLineAutoResizeWithMaxWidth:CELL_Width / 3];
        
        self.timeLabel.sd_layout
        .rightSpaceToView(self.contentView, margin)
        .topSpaceToView(self.showImageView3, margin)
        .autoHeightRatio(0)
        .minWidthIs(miniWidth);
        [self.timeLabel setSingleLineAutoResizeWithMaxWidth:CELL_Width / 3];
        
        self.lineView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(1.5)
        .topSpaceToView(self.nameLabel, margin);
        
        [self setupAutoHeightWithBottomView:self.lineView bottomMargin:0];
        [self.contentView setSd_equalWidthSubviews:@[self.showImageView1, self.showImageView2, self.showImageView3]];
    }
    
    return self;
}

- (void)setDynamicList:(DynamicList *)dynamicList
{
    [self.showImageView1 sd_setImageWithURL:[NSURL URLWithString:dynamicList.attaches.firstObject] placeholderImage:[UIImage imageNamed:@"load.jpg"]];
    
    [self.showImageView2 sd_setImageWithURL:[NSURL URLWithString:dynamicList.attaches[1]] placeholderImage:[UIImage imageNamed:@"load.jpg"]];
    
    [self.showImageView3 sd_setImageWithURL:[NSURL URLWithString:dynamicList.attaches[2]] placeholderImage:[UIImage imageNamed:@"load.jpg"]];
    
    self.nameLabel.text = dynamicList.source;
    self.titleLabel.text = dynamicList.title;
    self.countLabel.text = dynamicList.views_num;
    self.timeLabel.text = dynamicList.push_at;
}

@end
