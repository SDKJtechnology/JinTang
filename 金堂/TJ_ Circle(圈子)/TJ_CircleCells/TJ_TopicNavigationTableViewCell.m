//
//  TJ_TopicNavigationTableViewCell.m
//  金堂
//
//  Created by SDKJ on 16/4/22.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_TopicNavigationTableViewCell.h"
#import "SDAutoLayout.h"

@implementation TJ_TopicNavigationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *newTopicButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [newTopicButton setBackgroundImage:[[UIImage imageNamed:@"zuixinhuati"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        newTopicButton.backgroundColor = [UIColor colorWithRed:0.239 green:0.638 blue:0.955 alpha:1.000];
        newTopicButton.tag = TJ_TopicNavigationNewTopicButtonTag;
        [newTopicButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *myTopicButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [myTopicButton setBackgroundImage:[[UIImage imageNamed:@"wodehuati"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        myTopicButton.backgroundColor = [UIColor colorWithRed:0.133 green:0.556 blue:0.255 alpha:1.000];
        myTopicButton.tag = TJ_TopicNavigationMyTopicButtonTag;
        [myTopicButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView sd_addSubviews:@[newTopicButton, myTopicButton]];
        
        CGFloat margin = 10;
        
        newTopicButton.sd_layout
        .topSpaceToView(self.contentView, margin)
        .leftSpaceToView(self.contentView, margin)
        .bottomSpaceToView(self.contentView, margin)
        .widthIs((self.width - 3 * margin) / 2);
        newTopicButton.sd_cornerRadius = @5;
        //        NSLog(@"%f",(self.width - 3 * margin) / 2);
        myTopicButton.sd_layout
        .topSpaceToView(self.contentView, margin)
        .leftSpaceToView(newTopicButton, margin)
        .bottomSpaceToView(self.contentView, margin)
        .widthIs((self.width - 3 * margin) / 2);
        myTopicButton.sd_cornerRadius = newTopicButton.sd_cornerRadius;
    }
    
    return self;
}

- (void)clickButtonAction:(UIButton *)sender
{
    NSString *title = nil;
    if (sender.tag == TJ_TopicNavigationNewTopicButtonTag)
    {
        
        title = @"最新话题";
    }
    else if (sender.tag == TJ_TopicNavigationMyTopicButtonTag)
    {
        title = @"我的话题";
    }
     [self.delegate didClickTopicNavigationButton:self Titel:title];
}

@end
