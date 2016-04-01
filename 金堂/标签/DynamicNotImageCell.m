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
        
        self.nameLabel.sd_layout
        .bottomSpaceToView(self.contentView, margin)
        .leftSpaceToView(self.contentView, margin)
        .autoHeightRatio(0);
        [self.nameLabel setSingleLineAutoResizeWithMaxWidth:CELL_Width / 3];
        
        self.countLabel.sd_layout
        .leftSpaceToView(self.nameLabel, margin)
        .bottomSpaceToView(self.contentView, margin)
        .autoHeightRatio(0);
        [self.countLabel setSingleLineAutoResizeWithMaxWidth:CELL_Width / 3];
        
        self.timeLabel.sd_layout
        .rightSpaceToView(self.contentView, margin)
        .bottomSpaceToView (self.contentView, margin)
        .autoHeightRatio(0);
        [self.timeLabel setSingleLineAutoResizeWithMaxWidth:CELL_Width / 3];
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
