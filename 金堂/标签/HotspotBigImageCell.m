//
//  HotspotBigImageCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/11.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "HotspotBigImageCell.h"

@implementation HotspotBigImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.image = [UIImageView new];
        [self.contentView addSubview:self.image];
        self.backgroundColor = [UIColor colorWithWhite:0.919 alpha:1.000];
        self.contentView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 13, 0, 13));
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [UILabel new];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.backgroundColor = [UIColor colorWithWhite:0.382 alpha:0.400];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        
        CGFloat margin = 6.5;
        
        self.image.sd_layout
        .leftSpaceToView(self.contentView, margin)
        .rightSpaceToView(self.contentView, margin)
        .autoHeightRatio(0.5);
        
        self.titleLabel.sd_layout
        .leftEqualToView(self.image)
        .rightEqualToView(self.image)
        .bottomEqualToView(self.image)
        .autoHeightRatio(0);
        
        [self setupAutoHeightWithBottomViewsArray:@[self.image, self.titleLabel] bottomMargin:5];
    }
    
    return self;
}

- (void)setHeader:(Body *)header
{
    self.titleLabel.text = header.title;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:header.imageUrl] placeholderImage:[UIImage imageNamed:@"load"]];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
