//
//  HotspotBigImageCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/11.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "ActivityBigImageCell.h"
#import "TJ_BAButton.h"

@interface ActivityBigImageCell ()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) TJ_BACustomButton *activityButton;

@end

@implementation ActivityBigImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.image = [UIImageView new];
        [self.contentView addSubview:self.image];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [UILabel new];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        
        self.stateLabel = [UILabel new];
        [self.contentView addSubview:self.stateLabel];
        self.stateLabel.textColor = [UIColor whiteColor];
        self.stateLabel.font = [UIFont systemFontOfSize:13];
        self.stateLabel.backgroundColor = [UIColor colorWithWhite:0.139 alpha:0.6];
        
        self.activityButton = [TJ_BACustomButton buttonWithType:UIButtonTypeCustom];
        [self.activityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.activityButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.activityButton];
        
        CGFloat margin = 10;
        
        self.titleLabel.sd_layout
        .leftSpaceToView(self.contentView, margin)
        .rightSpaceToView(self.contentView, margin)
        .topSpaceToView(self.contentView, 5)
        .heightIs(40);
        
        self.image.sd_layout
        .topSpaceToView(self.titleLabel, 5)
        .leftEqualToView(self.titleLabel)
        .rightEqualToView(self.titleLabel)
        .autoHeightRatio(0.5);
        
        self.stateLabel.sd_layout
        .leftSpaceToView(self.contentView, margin)
        .rightSpaceToView(self.contentView, margin)
        .bottomEqualToView(self.image)
        .heightIs(30);
        
        self.activityButton.sd_layout
        .rightSpaceToView(self.contentView, margin)
        .bottomEqualToView(self.image)
        .widthIs(100)
        .heightIs(30);
        
        UIView *lineView = [UIView new];
        [self.contentView addSubview:lineView];
        
        lineView.sd_layout
        .topSpaceToView(self.image, 0)
        .leftSpaceToView(self.contentView, 0)
        .widthIs(self.contentView.width)
        .heightIs(margin);
        
        [self setupAutoHeightWithBottomView:lineView bottomMargin:0];
    }
    
    return self;
}

- (void)setActivityModel:(DynamicActivityModel *)activityModel
{
    self.titleLabel.text = activityModel.title;
    self.stateLabel.text = [NSString stringWithFormat: @"活动时间:%@ — %@",activityModel.startDate,activityModel.endDate];
    [self.activityButton setTitle:@"立即参与﹥" forState:UIControlStateNormal];
    [self.activityButton setButtonTruthWidth];
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:activityModel.image_Url] placeholderImage:[UIImage imageNamed:@"load"]];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
