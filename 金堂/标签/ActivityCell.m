//
//  ActivityCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/12.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "ActivityCell.h"
#import "SDAutoLayout.h"

@implementation ActivityCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat margin = 10;
        
        self.imageView.sd_layout
        .topSpaceToView(self.contentView, margin)
        .leftSpaceToView(self.contentView, margin)
        .minWidthIs(120)
        .widthIs(self.contentView.width * 2 / 5)
        .autoHeightRatio(0.7);
        self.imageView.image = [UIImage imageNamed:@"beijing"];
        
        self.textLabel.sd_layout
        .leftSpaceToView(self.imageView, margin)
        .centerYEqualToView(self.imageView)
        .rightSpaceToView(self.contentView, margin);
        self.textLabel.numberOfLines = 3;
        self.textLabel.text = @"是短发舒服撒帝国大厦风味肉 i 途径哦 i 激发";
        
        [self setupAutoHeightWithBottomView:self.imageView bottomMargin:margin];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end
