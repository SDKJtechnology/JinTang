
//
//  HotCollectionViewCell.m
//  金堂
//
//  Created by SDKJ on 16/4/14.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "SDAutoLayout.h"
#import "TJ_HotCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface TJ_HotCollectionViewCell()

@property (nonatomic) UIImageView *imageView;//背景试图

@property (nonatomic) TJ_BACustomButton *headButton;//头像按钮

@property (nonatomic, strong) UILabel *nameLabel;//昵称label

@property (nonatomic, strong) UIView *backView;//透明视图

@end

@implementation TJ_HotCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.imageView = [UIImageView new];
        self.backView = [UIView new];
        self.nameLabel = [UILabel new];

        self.headButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusLeft];
        
        [self.contentView sd_addSubviews:@[self.imageView,self.backView,self.headButton,self.nameLabel]];
        
        [self setup];
    }
    
    return self;
}

- (void)setup
{    
    self.imageView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png"] placeholderImage:[UIImage imageNamed:@"load"]];
    
    self.headButton.sd_layout
    .leftSpaceToView(self.contentView, 3)
    .bottomSpaceToView(self.contentView, 3)
    .heightRatioToView(self.contentView, 0.3)
    .widthEqualToHeight();
    self.headButton.sd_cornerRadiusFromWidthRatio = @0.5;
    [self.headButton setImage:[UIImage imageNamed:@"ai@3x"] forState:UIControlStateNormal];
    [self.headButton addTarget:self action:@selector(clickHeadButtonAction) forControlEvents:
     UIControlEventTouchUpInside];
    
    self.backView.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0)
    .heightIs(self.contentView.height * 0.3 + 6);
    self.backView.backgroundColor = [UIColor colorWithWhite:0.131 alpha:0.650];
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.headButton, 5)
    .rightSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0)
    .heightIs(self.backView.height);
    self.nameLabel.font = [UIFont systemFontOfSize:10];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.text = @"金堂妹妹";
}

- (void)clickHeadButtonAction
{
    NSLog(@"点击头像");
}

@end
