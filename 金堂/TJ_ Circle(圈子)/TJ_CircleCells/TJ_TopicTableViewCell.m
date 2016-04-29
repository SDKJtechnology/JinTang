//
//  Tj_TopicTableViewCell.m
//  金堂
//
//  Created by SDKJ on 16/4/15.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_TopicTableViewCell.h"
#import "SDAutoLayout.h"

@implementation TJ_TopicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.identifierImage = [UIImageView new];
        [self.contentView addSubview:self.identifierImage];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    
    self.imageView.sd_layout
    .topSpaceToView(self.contentView, margin / 2)
    .leftSpaceToView(self.contentView, margin)
    .bottomSpaceToView(self.contentView, margin / 2)
    .widthEqualToHeight();

    self.identifierImage.sd_layout
    .topSpaceToView(self.contentView, margin / 2)
    .leftSpaceToView(self.contentView, margin)
    .heightRatioToView(self.imageView, 0.4)
    .widthEqualToHeight();
//    self.identifierImage.backgroundColor = [UIColor redColor];
    [self.contentView bringSubviewToFront:self.identifierImage];
    
    self.textLabel.sd_layout
    .leftSpaceToView(self.imageView, margin)
    .topEqualToView(self.imageView);
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.font = [UIFont systemFontOfSize:14];
    
    self.detailTextLabel.sd_layout
    .leftSpaceToView(self.imageView, margin)
    .bottomEqualToView(self.imageView);
    self.detailTextLabel.font = [UIFont systemFontOfSize:11];
    self.detailTextLabel.textColor = [UIColor colorWithWhite:0.591 alpha:1.000];
}

- (void)setTopicModel:(TopicModel *)topicModel
{
    self.textLabel.text = topicModel.titleString;
    self.detailTextLabel.text = topicModel.detailString;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.sharedImageUrls.lastObject] placeholderImage:[UIImage imageNamed:@"load"]];
}

@end

