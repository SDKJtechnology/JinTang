
//
//  HotCollectionViewCell.m
//  金堂
//
//  Created by SDKJ on 16/4/14.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "SDAutoLayout.h"
#import "TJ_HotCollectionViewCell.h"

@interface TJ_HotCollectionViewCell()

@end

@implementation TJ_HotCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        self.backgroundImage = [UIImageView new];
        self.titleLabel = [UILabel new];
        self.supportButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusNormal];
        self.nameButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusLeft];
        self.contentLabel = [UILabel new];
        
        [self.contentView sd_addSubviews:@[self.backgroundImage,self.nameButton,self.contentLabel,self.titleLabel,self.supportButton]];
        
        [self layout];
    }
    
    return self;
}

- (void)layout
{
    CGFloat margin = 10;
    
    self.backgroundImage.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    self.titleLabel.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, margin)
    .rightSpaceToView(self.contentView, margin)
    .heightIs(self.contentView.height / 3);
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    self.titleLabel.text = @"仨快递放假快乐";
    
    self.contentLabel.sd_layout
    .topSpaceToView(self.titleLabel, 0)
    .leftSpaceToView(self.contentView, margin * 2.5)
    .rightSpaceToView(self.contentView, margin)
    .heightIs(self.titleLabel.height);
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    [self.contentLabel setTextColor:self.titleLabel.textColor];
    self.contentLabel.text = @"萨肯邓丽君佛拉数据的佛 i 阿萨德将佛教萨快点放假快乐撒娇的风口浪尖啊生动风景";
    
    self.nameButton.sd_layout
    .heightIs(25)
    .widthIs(self.contentView.width / 2)
    .leftEqualToView(self.titleLabel)
    .bottomSpaceToView(self.contentView, margin);
    [self.nameButton setTitleColor:self.titleLabel.textColor forState:UIControlStateNormal];
    self.nameButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.nameButton setTitle:@"萨芬的告诉对方" forState:UIControlStateNormal];
    
    self.supportButton.sd_layout
    .heightIs(self.nameButton.height)
    .rightSpaceToView(self.contentView, margin)
    .widthIs(200)
    .bottomEqualToView(self.nameButton);
    [self.supportButton setTitleColor:self.titleLabel.textColor forState:UIControlStateNormal];
    self.supportButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.supportButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self.supportButton setTitle:@"1221" forState:UIControlStateNormal];
    self.supportButton.sd_layout.widthIs([self.supportButton getTitleLabelWith].size.width + [self.supportButton getImageViewFrame].size.width);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.tag % 4 == 0 || (self.tag + 1) % 4 == 0)
        self.backgroundImage.image = [UIImage imageNamed:@"beijing"];
    else
    {
        self.titleLabel.textColor = [UIColor colorWithWhite:0.187 alpha:1.000];
        [self.supportButton setTitleColor:self.titleLabel.textColor forState:UIControlStateNormal];
        [self.nameButton setTitleColor:self.titleLabel.textColor forState:UIControlStateNormal];
        [self.contentLabel setTextColor:self.titleLabel.textColor];
    }
}


@end
