//
//  TJ_GachincoTableViewCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/16.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_CommentTableViewCell.h"

@implementation TJ_CommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.commetView = [TJ_CommetView new];
        [self.contentView addSubview:self.commetView];
        
        self.headerButton.sd_cornerRadiusFromHeightRatio = @.5;
        [self.nameButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

        self.titleLabel.sd_layout
        .leftEqualToView(self.timeLabel);
//        self.titleLabel.delegate = self;
//        self.titleLabel.dataDetectorTypes = MLDataDetectorTypeHashtag;
        
        self.sharedPhotoView.sd_resetLayout
        .leftEqualToView(self.titleLabel)
        .rightEqualToView(self.titleLabel)
        .topSpaceToView(self.titleLabel, margin);
        
        self.shareButton.sd_resetLayout
        .leftEqualToView(self.titleLabel)
        .topSpaceToView(self.sharedPhotoView, 0)
        .widthIs(60)
        .heightIs(20);
        self.shareButton.backgroundColor = [UIColor colorWithWhite:0.875 alpha:1.000];
        self.shareButton.sd_cornerRadius = @5 ;
        [self.contentView bringSubviewToFront:self.shareButton];
        
        self.replyCountButton.sd_resetLayout
        .topSpaceToView(self.sharedPhotoView, 0)
        .rightEqualToView(self.sharedPhotoView)
        .widthIs(self.shareButton.width)
        .heightIs(self.shareButton.height);
        self.replyCountButton.backgroundColor = self.shareButton.backgroundColor;
        self.replyCountButton.sd_cornerRadius = self.shareButton.sd_cornerRadius;
        [self.replyCountButton updateLayout];
        
        self.supportCountButton.sd_layout
        .topEqualToView(self.replyCountButton)
        .rightSpaceToView(self.replyCountButton, 5)
        .widthIs(self.replyCountButton.width)
        .heightIs(self.replyCountButton.height);
        self.supportCountButton.backgroundColor = self.shareButton.backgroundColor;
        self.supportCountButton.sd_cornerRadius = self.shareButton.sd_cornerRadius;
        
        self.commetView.sd_layout
        .topSpaceToView(self.shareButton, margin)
        .leftEqualToView(self.shareButton)
        .rightEqualToView(self.sharedPhotoView);
        self.commetView.backgroundColor = [UIColor grayColor];
        
        [self setupAutoHeightWithBottomView:self.commetView bottomMargin:margin];
    }
    
    return self;
}

- (void)setGachincoModel:(GachincoModel *)gachincoModel
{
 
    CommentModel *model = [CommentModel new];
    
    [self.commetView setupWithLikeItemsArray:gachincoModel.sharedImageUrls commentItemsArray:@[model,model,model,model]];
    
    [self.headerButton sd_setImageWithURL:[NSURL URLWithString:gachincoModel.headImageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"头像"]];
    
    self.sexImageView.image = [UIImage imageNamed:@"nv"];
    
    self.titleLabel.text = gachincoModel.titleString;
    
    self.timeLabel.text = gachincoModel.timeString;
    
    [self.nameButton setTitle:gachincoModel.sourceName forState:UIControlStateNormal];
    [self.nameButton setButtonTruthWidth];
    
    self.sharedPhotoView.imageUrlArray = gachincoModel.sharedImageUrls;
    
    [self.replyCountButton setImage:[UIImage imageNamed:@"lun"] forState:UIControlStateNormal];
    [self.replyCountButton setTitle:@"评论" forState:UIControlStateNormal];
    [self.replyCountButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.supportCountButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self.supportCountButton setTitle:@"赞" forState:UIControlStateNormal];
    [self.supportCountButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.shareButton.enabled = YES;
    [self.shareButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)buttonAction:(TJ_BACustomButton *)sender
{
    NSLog(@"最新页面地址按钮");
}

- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    NSLog(@"%@",link.linkValue);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
