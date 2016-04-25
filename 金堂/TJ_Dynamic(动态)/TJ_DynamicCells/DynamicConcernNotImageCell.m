//
//  ModelTableViewCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicConcernNotImageCell.h"
#import "TJ_SharedPhotoView.h"


@implementation DynamicConcernNotImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.titleLabel.sd_layout
    .topSpaceToView(self.headerButton, margin / 2)
    .leftSpaceToView(self.contentView, margin)
    .rightSpaceToView(self.contentView, margin)
    .autoHeightRatio(0);
    
    self.sharedPhotoView.sd_layout
    .topSpaceToView(self.titleLabel, margin)
    .leftEqualToView(self.titleLabel)
    .rightEqualToView(self.titleLabel);
    
    self.nameButton.sd_layout
    .topSpaceToView(self.sharedPhotoView, margin / 2)
    .leftEqualToView(self.titleLabel)
    .widthIs(150)
    .heightIs(20);
    [self.nameButton setTitleColor:self.browseCountButton.currentTitleColor forState:UIControlStateNormal];
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.sharedPhotoView, margin / 2)
    .rightEqualToView(self.titleLabel)
    .autoHeightRatio(0);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.browseCountButton.sd_layout
    .topEqualToView(self.timeLabel)
    .leftSpaceToView(self.nameButton, margin)
    .widthIs(150)
    .heightIs(20);
    
    [self setupAutoHeightWithBottomView:self.browseCountButton bottomMargin:margin / 2];
}

- (void)setDynamicList:(DynamicList *)dynamicList
{
    [self.nameButton setTitle:dynamicList.source forState:UIControlStateNormal];
    self.nameButton.sd_layout.widthIs([self.nameButton getButtonWidth].size.width);
    
    self.sharedPhotoView.imageUrlArray = dynamicList.attaches;
    
    self.titleLabel.text = dynamicList.title;
        
    self.timeLabel.text = dynamicList.push_at;
    
    [self.browseCountButton setTitle:dynamicList.views_num forState:UIControlStateNormal];
    self.browseCountButton.sd_layout.widthIs([self.browseCountButton getButtonWidth].size.width);
}

+ (NSString *)identifierForModelAtRow:(id)Model
{
    DynamicList *model = Model;
    switch (model.attaches.count) {
        case 0:
            return @"DynamicConcernNotImageCell";
            break;
        case 1:
            return @"DynamicConcernOneImageCell";
            break;
        default:
            return @"DynamicConcernManyImageCell";
            break;
    }
}

- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    _po(linkText);
}

@end
