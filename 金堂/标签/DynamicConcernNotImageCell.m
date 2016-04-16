//
//  ModelTableViewCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicConcernNotImageCell.h"
#import "UILabel+new.h"
#import "TJ_SharedPhotoView.h"


@implementation DynamicConcernNotImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    
    return self;
}

- (void)setDynamicList:(DynamicList *)dynamicList
{
    [self.headerButton setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    
    self.titleLabel.text = dynamicList.title;
    
    [self.nameButton setTitle:dynamicList.source forState:UIControlStateNormal];
    [self.nameButton setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
    
    self.timeLabel.text = dynamicList.push_at;
    
    [self.addressButton setTitle:@"金堂印象" forState:UIControlStateNormal];
    self.addressButton.sd_layout.widthIs([self.addressButton getTitleLabelWith].size.width);
    
    [self.replyCountButton setImage:[UIImage imageNamed:@"lun"] forState:UIControlStateNormal];
    [self.replyCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.replyCountButton.sd_layout.widthIs([self.replyCountButton getButtonWidth].size.width);
    
    [self.supportCountButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self.supportCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.supportCountButton.sd_layout.widthIs([self.supportCountButton getButtonWidth].size.width);
    
    [self.browseCountButton setImage:[UIImage imageNamed:@"kan"] forState:UIControlStateNormal];
    [self.browseCountButton setTitle:@"1252" forState:UIControlStateNormal];
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

@end

@implementation DynamicConcernOneImageCell

- (void)setDynamicList:(DynamicList *)dynamicList
{
    self.replyCountButton.sd_layout.topSpaceToView(self.sharedPhotoView, margin / 2);
    self.sharedPhotoView.imageUrlArray = dynamicList.attaches;
    
    [self.headerButton setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    
    self.titleLabel.text = dynamicList.title;
    
    [self.nameButton setTitle:dynamicList.source forState:UIControlStateNormal];
    [self.nameButton setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
    
    [self.addressButton setTitle:@"金堂印象" forState:UIControlStateNormal];
    self.addressButton.sd_layout.widthIs([self.addressButton getTitleLabelWith].size.width);
    
    self.timeLabel.text = dynamicList.push_at;
    
    [self.replyCountButton setImage:[UIImage imageNamed:@"lun"] forState:UIControlStateNormal];
    [self.replyCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.replyCountButton.sd_layout.widthIs([self.replyCountButton getButtonWidth].size.width);
    
    [self.supportCountButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self.supportCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.supportCountButton.sd_layout.widthIs([self.supportCountButton getButtonWidth].size.width);
    
    [self.browseCountButton setImage:[UIImage imageNamed:@"kan"] forState:UIControlStateNormal];
    [self.browseCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.browseCountButton.sd_layout.widthIs([self.browseCountButton getButtonWidth].size.width);
}

@end

@implementation DynamicConcernManyImageCell

- (void)setDynamicList:(DynamicList *)dynamicList
{
    self.replyCountButton.sd_layout.topSpaceToView(self.sharedPhotoView, margin / 2);

    [self.headerButton setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    
    self.titleLabel.text = dynamicList.title;
    
    [self.nameButton setTitle:dynamicList.source forState:UIControlStateNormal];
    [self.nameButton setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
    
    self.timeLabel.text = dynamicList.push_at;
    
    [self.addressButton setTitle:@"金堂印象" forState:UIControlStateNormal];
    self.addressButton.sd_layout.widthIs([self.addressButton getTitleLabelWith].size.width);
    
    [self.replyCountButton setImage:[UIImage imageNamed:@"lun"] forState:UIControlStateNormal];
    [self.replyCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.replyCountButton.sd_layout.widthIs([self.replyCountButton getButtonWidth].size.width);
    
    [self.supportCountButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self.supportCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.supportCountButton.sd_layout.widthIs([self.supportCountButton getButtonWidth].size.width);
    
    [self.browseCountButton setImage:[UIImage imageNamed:@"kan"] forState:UIControlStateNormal];
    [self.browseCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.browseCountButton.sd_layout.widthIs([self.browseCountButton getButtonWidth].size.width);
    
    self.sharedPhotoView.imageUrlArray = dynamicList.attaches;
}

@end
