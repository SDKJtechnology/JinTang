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
        .widthIs(50)
        .heightEqualToWidth()
        .topSpaceToView(self.contentView, margin)
        .rightSpaceToView(self.contentView, margin);
        
        self.textLabel.sd_layout
        .topEqualToView(self.image)
        .leftSpaceToView(self.contentView, margin)
        .centerYIs(self.image.centerY)
        .rightSpaceToView(self.image, margin);
        self.textLabel.numberOfLines = 3;
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.font = [UIFont systemFontOfSize:13];
        
        [self setupAutoHeightWithBottomView:self.image bottomMargin:margin];
    }
    
    return self;
}

- (void)setHotspotModel:(DynamicHotspotModel *)hotspotModel
{
    self.textLabel.text = hotspotModel.title;
    Image *image = hotspotModel.imagesUrl.firstObject;
    [self.image sd_setImageWithURL:[NSURL URLWithString:image.imageUrl] placeholderImage:[UIImage imageNamed:@"load"]];
}

@end
