//
//  TJ_GachincoTableViewCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/16.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_GachincoTableViewCell.h"

@implementation TJ_GachincoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.commetView = [TJ_CommetView new];
        [self.contentView addSubview:self.commetView];
        
        self.shareButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusNormal];
        [self.contentView addSubview:self.shareButton];
        
        self.headerButton.sd_cornerRadiusFromHeightRatio = @.5;
        [self.nameButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.addressButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.titleLabel.sd_layout
        .leftEqualToView(self.timeLabel);
        
        self.sharedPhotoView.sd_resetLayout
        .leftEqualToView(self.titleLabel)
        .rightEqualToView(self.titleLabel)
        .topSpaceToView(self.titleLabel, margin);
        
        self.supportCountButton.sd_resetLayout
        .leftEqualToView(self.titleLabel)
        .topSpaceToView(self.sharedPhotoView, 0)
        .widthIs(40)
        .heightIs(15);
        self.supportCountButton.backgroundColor = [UIColor colorWithWhite:0.875 alpha:1.000];
        self.supportCountButton.sd_cornerRadiusFromHeightRatio = @0.5;
        
        self.replyCountButton.sd_resetLayout
        .topSpaceToView(self.sharedPhotoView, 0)
        .rightEqualToView(self.addressButton)
        .widthIs(self.supportCountButton.width)
        .heightIs(self.supportCountButton.height);
        self.replyCountButton.backgroundColor = self.supportCountButton.backgroundColor;
        self.replyCountButton.sd_cornerRadiusFromHeightRatio = self.supportCountButton.sd_cornerRadiusFromHeightRatio;
        
        self.shareButton.sd_layout
        .topEqualToView(self.supportCountButton)
        .widthIs(self.supportCountButton.width)
        .heightIs(self.supportCountButton.height);
        self.shareButton.backgroundColor = self.supportCountButton.backgroundColor;
        self.shareButton.sd_cornerRadiusFromHeightRatio = self.supportCountButton.sd_cornerRadiusFromHeightRatio;
        
        self.commetView.sd_layout
        .topSpaceToView(self.supportCountButton, margin)
        .leftEqualToView(self.supportCountButton)
        .rightEqualToView(self.sharedPhotoView);
        self.commetView.backgroundColor = [UIColor grayColor];
        
        [self setupAutoHeightWithBottomView:self.commetView bottomMargin:margin];
    }
    
    return self;
}

- (void)layoutSubviews
{
    CGPoint center = self.shareButton.center;
    center.x = self.sharedPhotoView.center.x;
    self.shareButton.center = center;
    
    [super layoutSubviews];
}

- (void)setGachincoModel:(GachincoModel *)gachincoModel
{
    self.commetView.commetData = @[@"",@"",@"",@""];
    
    [self.headerButton sd_setImageWithURL:[NSURL URLWithString:gachincoModel.headImageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"头像"]];
    
    self.titleLabel.text = gachincoModel.titleString;
    
    self.timeLabel.text = gachincoModel.timeString;
    
    self.addressLabel.text = @"来自";
    
    [self.addressButton setTitle:gachincoModel.addressesSting forState:UIControlStateNormal];
    
    self.addressButton.sd_layout.widthIs([self.addressButton getButtonWidth].size.width);
    
    [self.nameButton setTitle:gachincoModel.sourceName forState:UIControlStateNormal];
    
    self.sharedPhotoView.imageUrlArray = gachincoModel.sharedImageUrls;
    
    [self.replyCountButton setImage:[UIImage imageNamed:@"lun"] forState:UIControlStateNormal];
    
    [self.supportCountButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    
    [self.shareButton setImage:[UIImage imageNamed:@"kan"] forState:UIControlStateNormal];
    
}

+ (NSString *)identifierForModelAtRow:(id)Model
{
    GachincoModel *model = Model;
    switch (model.sharedImageUrls.count) {
        case 1:
            return @"oneImage";
            break;
        case 2:
            return @"towImge";
            break;
        default:
            return @"threeImage";
            break;
    }
}

- (void)buttonAction
{
    NSLog(@"最新页面地址按钮");
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
