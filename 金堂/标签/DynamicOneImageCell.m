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
        self.showImageView1.sd_layout
        .widthIs(288)
        .heightIs(288)
        .rightSpaceToView(self.contentView, margin)
        .bottomSpaceToView(self.contentView, margin);
        
        self.titleLabel.sd_layout
        .leftSpaceToView(self.showImageView1, margin)
        .topSpaceToView(self.showImageView1, margin)
        .rightSpaceToView(self.showImageView1, margin)
        .autoHeightRatio(0);
        
        self.nameLabel.sd_layout
        .leftSpaceToView(self.contentView, margin)
        .bottomSpaceToView(self.contentView, margin)
        .autoHeightRatio(0);
        [self.nameLabel setSingleLineAutoResizeWithMaxWidth:CELL_Width / 3];
        
        self.countLabel.sd_layout
        .leftSpaceToView(self.nameLabel, margin)
        .bottomSpaceToView(self.contentView, margin)
        .autoHeightRatio(0);
        [self.countLabel setSingleLineAutoResizeWithMaxWidth:CELL_Width / 3];
    }
    
    return self;
}

- (void)setDynamicList:(DynamicList *)dynamicList
{
    self.titleLabel.text = dynamicList.title;
    self.nameLabel.text = dynamicList.source;
    self.countLabel.text = dynamicList.views_num;
//    dynamicList.attaches = [AttachesImage ]
//    [self.showImageView1 sd_setImageWithURL:[NSURL URLWithString:dynamicList.attaches.firstObject]];
}

@end
