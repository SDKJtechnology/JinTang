//
//  TJ_EnshrineTableViewCell.m
//  金堂
//
//  Created by SDKJ on 16/4/26.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_EnshrineTableViewCell.h"

@interface TJ_EnshrineTableViewCell ()

@property (nonatomic, strong) UILabel *imageLabel;

@end

@implementation TJ_EnshrineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        
        [self setup];
    }
                 
     return self;
}

- (void)setup
{
    self.imageLabel = [UILabel new];
    [self.contentView addSubview:self.imageLabel];
    self.imageLabel.sd_layout
    .topSpaceToView(self.contentView, margin)
    .leftSpaceToView(self.contentView, margin)
    .widthIs(15)
    .heightEqualToWidth();
    self.imageLabel.sd_cornerRadius = @2;
    self.imageLabel.text = @"图";
    self.imageLabel.textColor = [UIColor colorWithRed:0.000 green:0.569 blue:0.003 alpha:1.000];
    self.imageLabel.layer.borderColor = [self.imageLabel.textColor CGColor];
    self.imageLabel.layer.borderWidth = 0.7;
    self.imageLabel.textAlignment = NSTextAlignmentCenter;
    self.imageLabel.font = [UIFont fontWithName:TJFont size:10];
    
    self.titleLabel.sd_layout
    .topSpaceToView(self.contentView, margin)
    .leftSpaceToView(self.imageLabel, 0)
    .rightSpaceToView(self.contentView, margin)
    .autoHeightRatio(0);
    self.titleLabel.font = [UIFont fontWithName:TJFont size:14];
    self.titleLabel.textColor = [UIColor blackColor];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"拉萨克己复礼看撒娇的法律框架里卡水电费狂欢圣非架里卡水电费狂欢圣非架里卡水电费狂欢圣非得失舒服的沙发舒服水电费水电费"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [paragraphStyle setFirstLineHeadIndent:self.titleLabel.font.pointSize * 2];//首行缩进两个字体
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.titleLabel.text length])];
    self.titleLabel.attributedText = attributedString;
    
    self.replyCountButton.sd_layout
    .topSpaceToView(self.titleLabel, margin)
    .rightSpaceToView(self.contentView, margin)
    .widthIs(100)
    .heightIs(20);
    self.replyCountButton.enabled = NO;
    
    [self.replyCountButton setImage:[[UIImage imageNamed:@"lun"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.replyCountButton setTitle:@"44" forState:UIControlStateNormal];
    [self.replyCountButton setButtonTruthWidth];
    
    self.supportCountButton.sd_layout
    .topSpaceToView(self.titleLabel, margin)
    .rightSpaceToView(self.replyCountButton, margin / 2)
    .heightRatioToView(self.replyCountButton, 1)
    .widthIs(10);
    self.supportCountButton.enabled = NO;
    
    [self.supportCountButton setImage:[[UIImage imageNamed:@"zan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.supportCountButton setTitle:@"45" forState:UIControlStateNormal];
    [self.supportCountButton setButtonTruthWidth];
    
    [self setupAutoHeightWithBottomView:self.supportCountButton bottomMargin:margin];
}

@end
