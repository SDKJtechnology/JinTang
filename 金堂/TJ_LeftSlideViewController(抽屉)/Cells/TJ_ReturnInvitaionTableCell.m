//
//  TJ_ReturnInvitaionTableCell.m
//  金堂
//
//  Created by SDKJ on 16/5/13.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_ReturnInvitaionTableCell.h"

@implementation TJ_ReturnInvitaionTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel.sd_layout
        .topSpaceToView(self.contentView, margin)
        .leftSpaceToView(self.contentView, margin)
        .rightSpaceToView(self.contentView, margin)
        .autoHeightRatio(0);
        
        self.nameButton.sd_layout
        .topSpaceToView(self.titleLabel, margin)
        .leftSpaceToView(self.contentView, margin)
        .heightIs(30)
        .widthIs(100);
        
        self.browseCountButton.sd_layout
        .rightSpaceToView(self.contentView, margin)
        .topSpaceToView(self.titleLabel, margin);
        
        self.replyCountButton.sd_layout
        .topSpaceToView(self.titleLabel, margin)
        .rightSpaceToView(self.browseCountButton, margin);
        
        UIView *lineView = [UIView new];
        [self.contentView addSubview:lineView];
        lineView.sd_layout
        .topSpaceToView(self.nameButton, margin)
        .leftSpaceToView(self.contentView, margin * 0.5f)
        .rightSpaceToView(self.contentView, margin * 0.5f)
        .heightIs(0.5);
        lineView.backgroundColor = [UIColor colorWithWhite:0.723 alpha:1.000];
        
        [self setupAutoHeightWithBottomView:lineView bottomMargin:0];
    }
    
    return self;
}

- (void)setDynamicConcernsModel:(DynamicConcernsModel *)dynamicConcernsModel
{
    self.titleLabel.text = dynamicConcernsModel.title;
    
    [self.nameButton setTitle:dynamicConcernsModel.name forState:UIControlStateNormal];
    [self.nameButton setButtonTruthWidth];
    
    [self.browseCountButton setTitle:dynamicConcernsModel.readNumber forState:UIControlStateNormal];
    [self.browseCountButton setImage:[UIImage imageNamed:@"kan"] forState:UIControlStateNormal];
    [self.browseCountButton setButtonTruthWidth];
    
    [self.replyCountButton setTitle:dynamicConcernsModel.replyNumber forState:UIControlStateNormal];
    [self.replyCountButton setImage:[UIImage imageNamed:@"lun"] forState:UIControlStateNormal];
    [self.replyCountButton setButtonTruthWidth];
    [self.replyCountButton updateLayout];
}

@end
