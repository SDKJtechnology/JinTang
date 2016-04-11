//
//  HotspotSmallPictureCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/11.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "HotspotSmallPictureCell.h"

@implementation HotspotSmallPictureCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat margin = 6.5;
        
        self.image.sd_resetLayout
        .topSpaceToView(self.contentView, margin)
        .rightSpaceToView(self.contentView, margin)
        .bottomSpaceToView(self.contentView, margin)
        .maxHeightIs(80)
        .widthEqualToHeight();
        
        self.titleLabel
        .sd_resetLayout
        .leftSpaceToView(self.contentView, margin)
        .topSpaceToView(self.contentView, margin)
        .bottomSpaceToView(self.contentView, margin)
        .rightSpaceToView(self.image, margin);
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor blackColor];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    
}

- (void)setBody:(Body *)body
{
    self.titleLabel.text = body.title;
    [self.image sd_setImageWithURL:[NSURL URLWithString:body.imageUrl] placeholderImage:[UIImage imageNamed:@"load"]];
}

@end
