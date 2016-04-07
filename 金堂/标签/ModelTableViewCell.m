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
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:18];
        self.titleLabel.numberOfLines = 0;
        
        self.nameLabel = [UILabel new];
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.fontSize = 15;
        self.nameLabel.textColor = [UIColor grayColor];
        
        self.timeLabel = [UILabel new];
        [self.contentView addSubview:self.timeLabel];
        self.timeLabel.fontSize = self.nameLabel.fontSize;
        self.timeLabel.textColor = self.nameLabel.textColor;

        self.countLabel = [UILabel new];
        [self.contentView addSubview:self.countLabel];
        self.countLabel.fontSize = self.nameLabel.fontSize;
        self.countLabel.textColor = self.nameLabel.textColor;
        
        self.showImageView1 = [UIImageView new];
        [self.contentView addSubview:self.showImageView1];
        
        self.showImageView2 = [UIImageView new];
        [self.contentView addSubview:self.showImageView2];
        
        self.showImageView3 = [UIImageView new];
        [self.contentView addSubview:self.showImageView3];
        
        self.lineView = [UIView new];
        [self.contentView addSubview:self.lineView];
        
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.656 alpha:1.000];
    }
    
    return self;
}

+ (NSString *)identifierForModelAtRow:(DynamicList *)dynamicList
{
    switch (dynamicList.attaches.count) {
        case 1:
            return @"DynamicOneImageCell";
            break;
        case 3:
            return @"DynamicThreeImageCell";
            break;
        default:
            return @"DynamicNotImageCell";
            break;
    }
}

@end
