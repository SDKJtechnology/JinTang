//
//  ModelTableViewCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "ModelTableViewCell.h"

@implementation ModelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [UILabel new];
        [self.contentView addSubview:self.titleLabel];
        
        self.nameLabel = [UILabel new];
        [self.contentView addSubview:self.nameLabel];
        
        self.timeLabel = [UILabel new];
        [self.contentView addSubview:self.timeLabel];
        
        self.countLabel = [UILabel new];
        [self.contentView addSubview:self.countLabel];
        
        self.showImageView1 = [UIImageView new];
        [self.contentView addSubview:self.showImageView1];
        
        self.showImageView2 = [UIImageView new];
        [self.contentView addSubview:self.showImageView2];
        
        self.showImageView3 = [UIImageView new];
        [self.contentView addSubview:self.showImageView3];
    }
    
    return self;
}

@end
