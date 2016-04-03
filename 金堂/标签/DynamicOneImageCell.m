//
//  DynamicOneImageCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicOneImageCell.h"

@implementation DynamicOneImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat miniWidth = 50;
        
        self.titleLabel.sd_layout
        .leftSpaceToView(self.contentView, margin)
        .topSpaceToView(self.contentView, margin)
        .widthIs(CELL_Width * 4 / 5)
        .autoHeightRatio(0);
        
        self.showImageView1.sd_layout
        .rightSpaceToView(self.contentView, margin)
        .topSpaceToView(self.contentView, margin)
        .widthRatioToView(self.contentView, 0.3)
        .autoHeightRatio(0.7);

        self.nameLabel.sd_layout
        .leftSpaceToView(self.contentView, margin)
        .bottomEqualToView(self.showImageView1)
        .minWidthIs(miniWidth / 2)
        .autoHeightRatio(0);
        [self.nameLabel setSingleLineAutoResizeWithMaxWidth:CELL_Width / 2];
        
        self.countLabel.sd_layout
        .leftSpaceToView(self.nameLabel, margin)
        .bottomEqualToView(self.nameLabel)
        .minWidthIs(miniWidth)
        .autoHeightRatio(0);
        [self.countLabel setSingleLineAutoResizeWithMaxWidth:CELL_Width / 2];
        
        self.lineView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(1.5)
        .topSpaceToView(self.nameLabel, margin);
        
        [self setupAutoHeightWithBottomView:self.lineView bottomMargin:0];
    }
    
    return self;
}

- (void)setDynamicList:(DynamicList *)dynamicList
{
    self.titleLabel.text = dynamicList.title;
    self.nameLabel.text = dynamicList.source;
    self.countLabel.text = dynamicList.views_num;
    NSURL *url = [NSURL URLWithString:dynamicList.attaches.firstObject];
    [self.showImageView1 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"load.jpg"]];
}

@end
