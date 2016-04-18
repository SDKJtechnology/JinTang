//
//  Tj_TopicTableViewCell.m
//  金堂
//
//  Created by SDKJ on 16/4/15.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_TopicTableViewCell.h"
#import "SDAutoLayout.h"

@implementation TJ_TopicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.contentView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, margin / 2, 0, margin / 2));
        
        self.identifierLabel = [UILabel new];
        self.identifierLabel.font = [UIFont systemFontOfSize:12];
        self.identifierLabel.textColor = [UIColor whiteColor];
        self.identifierImage = [UIImageView new];
        self.shareImage1 = [UIImageView new];
        self.shareImage2 = [UIImageView new];
        [self.contentView addSubview:self.identifierImage];
        [self.contentView addSubview:self.identifierLabel];
        [self.contentView addSubview:self.shareImage2];
        [self.contentView addSubview:self.shareImage1];
        
        [self layout];
    }
    
    return self;
}

- (void)layout
{
    self.identifierImage.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .topSpaceToView(self.contentView, margin / 2)
    .widthIs(40)
    .autoHeightRatio(0.62);
    
    self.identifierLabel.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 2)
    .widthRatioToView(self.identifierImage, 1)
    .heightRatioToView(self.identifierImage, 1);
    
    self.titleLabel.sd_layout
    .topSpaceToView(self.identifierImage, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .autoHeightRatio(0);
    
    self.shareImage1.sd_layout
    .topSpaceToView(self.titleLabel, margin / 2)
    .leftEqualToView(self.titleLabel)
    .autoHeightRatio(1);
    
    self.shareImage2.sd_layout
    .topEqualToView(self.shareImage1)
    .leftSpaceToView(self.shareImage1, margin / 2)
    .rightSpaceToView(self.contentView, 0)
    .autoHeightRatio(1);
    [self.contentView setSd_equalWidthSubviews:@[self.shareImage1, self.shareImage2]];
    
    self.browseCountButton.sd_layout
    .topSpaceToView(self.shareImage2, margin / 2)
    .rightSpaceToView(self.contentView, 0)
    .widthIs(100)
    .heightIs(30);
    
    self.supportCountButton.sd_layout
    .topEqualToView(self.browseCountButton)
    .rightSpaceToView(self.browseCountButton, margin / 2)
    .widthIs(100)
    .heightRatioToView(self.browseCountButton, 1);
    
    [self.contentView setupAutoHeightWithBottomView:self.browseCountButton bottomMargin:margin / 2];
}

- (void)setTopicModel:(TopicModel *)topicModel
{
    self.titleLabel.text = topicModel.titleString;
    self.identifierImage.image = [UIImage imageNamed:@"sanjiaoxing"];
    self.identifierLabel.text = [NSString stringWithFormat:@"%ld",topicModel.ID];
    [self.browseCountButton setTitle:topicModel.browseCount forState:UIControlStateNormal];
    [self.browseCountButton setImage:[UIImage imageNamed:@"kan"] forState:UIControlStateNormal];
    [self.shareImage1 sd_setImageWithURL:topicModel.sharedImageUrls.firstObject placeholderImage:[UIImage imageNamed:@"load"]];
    [self.shareImage2 sd_setImageWithURL:topicModel.sharedImageUrls[1] placeholderImage:[UIImage imageNamed:@"load"]];
    self.browseCountButton.frame = [self.browseCountButton getButtonWidth];
    [self.supportCountButton setTitle:topicModel.supportCount forState:UIControlStateNormal];
    [self.supportCountButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    self.supportCountButton.frame = [self.supportCountButton getButtonWidth];
}

+ (NSString *)identifierForModelAtRow:(id)Model
{
    NSIndexPath *indexPath = Model;
    if (indexPath.section < 3)
        return NSStringFromClass([TJ_TopicTableViewCell class]);
    else return NSStringFromClass([Tj_TopicNotIdentifierImageCell class]);
}

@end

@implementation Tj_TopicNotIdentifierImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self set];
    }
    
    return self;
}

- (void)set
{
    self.identifierImage.hidden = YES;
    self.identifierLabel.hidden = YES;

    self.titleLabel.sd_layout
    .topSpaceToView(self.contentView, margin / 2)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .autoHeightRatio(0);
    
    self.shareImage1.sd_layout
    .topSpaceToView(self.titleLabel, margin / 2)
    .leftEqualToView(self.titleLabel)
    .autoHeightRatio(1);
    
    self.shareImage2.sd_layout
    .topEqualToView(self.shareImage1)
    .leftSpaceToView(self.shareImage1, margin / 2)
    .rightSpaceToView(self.contentView, 0)
    .autoHeightRatio(1);
    [self.contentView setSd_equalWidthSubviews:@[self.shareImage1, self.shareImage2]];
    
    self.browseCountButton.sd_layout
    .topSpaceToView(self.shareImage2, margin / 2)
    .rightSpaceToView(self.contentView, 0)
    .widthIs(100)
    .heightIs(30);
    
    self.supportCountButton.sd_layout
    .topEqualToView(self.browseCountButton)
    .rightSpaceToView(self.browseCountButton, margin / 2)
    .widthIs(100)
    .heightRatioToView(self.browseCountButton, 1);
    
    [self.contentView setupAutoHeightWithBottomView:self.browseCountButton bottomMargin:margin / 2];
}

@end
