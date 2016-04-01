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
        self.titleLabel = [UILabel new];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
        
        self.nameLabel = [UILabel new];
        [self.contentView addSubview:self.nameLabel];
//        self.nameLabel.backgroundColor = [UIColor yellowColor];
        self.nameLabel.fontSize = 15;
        self.nameLabel.textColor = [UIColor grayColor];
        
        self.timeLabel = [UILabel new];
        [self.contentView addSubview:self.timeLabel];
//        self.timeLabel.backgroundColor = [UIColor grayColor];
        self.timeLabel.fontSize = self.nameLabel.fontSize;
        self.timeLabel.textColor = self.nameLabel.textColor;

        self.countLabel = [UILabel new];
        [self.contentView addSubview:self.countLabel];
//        self.countLabel.backgroundColor = [UIColor greenColor];
        self.countLabel.fontSize = self.nameLabel.fontSize;
        self.countLabel.textColor = self.nameLabel.textColor;
        
        self.showImageView1 = [UIImageView new];
        [self.contentView addSubview:self.showImageView1];
        self.showImageView1.backgroundColor = [UIColor blueColor];
        
        self.showImageView2 = [UIImageView new];
        [self.contentView addSubview:self.showImageView2];
        self.showImageView2.backgroundColor = [UIColor blueColor];
        
        self.showImageView3 = [UIImageView new];
        [self.contentView addSubview:self.showImageView3];
        self.showImageView3.backgroundColor = [UIColor blueColor];
    }
    
    return self;
}

+ (NSString *)identifierForModelAtRow:(DynamicModel *)dynamicModel
{
    if (dynamicModel.imageUrl) {
        return @"DynamicOneImageCell";
    }else
        return @"DynamicNotImageCell";
}

@end
