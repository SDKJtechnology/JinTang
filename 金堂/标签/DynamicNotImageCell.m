//
//  DynamicNotImageCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicNotImageCell.h"
#import "XYString.h"

@implementation DynamicNotImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.titleLabel.sd_layout
        .topSpaceToView(self.contentView, margin)
        .leftSpaceToView(self.contentView, margin)
        .rightSpaceToView(self.contentView, margin)
        .autoHeightRatio(0);
        self.titleLabel.numberOfLines = 0;
        
        self.nameLabel.sd_layout
        .topSpaceToView(self.titleLabel, margin)
        .leftSpaceToView(self.contentView, margin)
        .autoHeightRatio(0);
        [self.nameLabel setSingleLineAutoResizeWithMaxWidth:CELL_Width / 3];
        
        self.countLabel.sd_layout
        .leftSpaceToView(self.nameLabel, margin)
        .topSpaceToView(self.titleLabel, margin)
        .autoHeightRatio(0);
        [self.countLabel setSingleLineAutoResizeWithMaxWidth:CELL_Width / 3];
        
        self.timeLabel.sd_layout
        .rightSpaceToView(self.contentView, margin)
        .topSpaceToView (self.titleLabel, margin)
        .autoHeightRatio(0);
        [self.timeLabel setSingleLineAutoResizeWithMaxWidth:CELL_Width / 3];
        
        self.lineView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(1.5)
        .topSpaceToView(self.timeLabel, margin);
        
        [self setupAutoHeightWithBottomView:self.lineView bottomMargin:0];
    }
    return self;
}

- (void)setDynamicList:(DynamicList *)dynamicList
{
    self.titleLabel.text = dynamicList.title;
    self.nameLabel.text = dynamicList.source;
    self.countLabel.text = dynamicList.views_num;
    self.timeLabel.text = dynamicList.push_at;
}

@end
