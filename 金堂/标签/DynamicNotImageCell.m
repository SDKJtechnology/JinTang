//
//  DynamicNotImageCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicNotImageCell.h"
#import "XYString.h"

@implementation DynamicNotImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
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
    CGRect frame = [self getTitleLabelTexeFrame:self.addressButton];
    self.addressButton.sd_layout.widthIs(frame.size.width);
    
    [self.replyCountButton setImage:[UIImage imageNamed:@"lun"] forState:UIControlStateNormal];
    [self.replyCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.replyCountButton.sd_layout.widthIs([self getTitleLabelTexeFrame:self.replyCountButton].size.width + [self getImageViewFrame:self.replyCountButton].size.width);
    
    [self.supportCountButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self.supportCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.supportCountButton.sd_layout.widthIs([self getTitleLabelTexeFrame:self.supportCountButton].size.width + [self getImageViewFrame:self.supportCountButton].size.width);
    
    [self.browseCountButton setImage:[UIImage imageNamed:@"kan"] forState:UIControlStateNormal];
    [self.browseCountButton setTitle:@"1252" forState:UIControlStateNormal];
    self.browseCountButton.sd_layout.widthIs([self getTitleLabelTexeFrame:self.browseCountButton].size.width + [self getImageViewFrame:self.browseCountButton].size.width);
}

@end
