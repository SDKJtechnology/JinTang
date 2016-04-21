//
//  ActivityCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/12.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "HotspotCell.h"
#import "SDAutoLayout.h"

@interface HotspotCell()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIImageView *image;

@end

@implementation HotspotCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat margin = 10;
        
        self.image = [UIImageView new];
        [self.contentView addSubview:self.image];
        
        self.image.sd_layout
        .widthIs(60)
        .heightEqualToWidth()
        .topSpaceToView(self.contentView, margin)
        .rightSpaceToView(self.contentView, margin);
        
        self.textLabel.sd_layout
        .topEqualToView(self.image)
        .leftSpaceToView(self.contentView, margin)
        .centerYIs(self.image.centerY)
        .rightSpaceToView(self.image, margin);
        self.textLabel.numberOfLines = 3;
        self.textLabel.font = [UIFont systemFontOfSize:13];
        
        self.lineView = [UIView new];
        [self.contentView addSubview:self.lineView];
        self.lineView.sd_layout
        .topSpaceToView(self.image, margin)
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(1);
        self.lineView.backgroundColor = [UIColor grayColor];
        
        [self setupAutoHeightWithBottomView:self.lineView bottomMargin:0];
    }
    
    return self;
}

- (void)setHotspotModel:(HotspotModel *)hotspotModel
{
    self.textLabel.text = hotspotModel.hotspotTitel;
    [self.image sd_setImageWithURL:[NSURL URLWithString:hotspotModel.hotspotImageUrl] placeholderImage:[UIImage imageNamed:@"load"]];
}

@end
