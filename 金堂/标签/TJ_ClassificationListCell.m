//
//  TJ_ClassificationListCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/17.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_ClassificationListCell.h"
#import <UIImageView+WebCache.h>

@interface TJ_ClassificationListCell()
{
    BOOL isConcern;
}

@property (nonatomic, strong) UIButton *concernButton;

@property (nonatomic, strong) UIImageView *image;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *concernLabel;

@end

@implementation TJ_ClassificationListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat margin = 5;
        
        self.image = [UIImageView new];
        self.titleLabel = [UILabel new];
        self.concernLabel = [UILabel new];
        self.concernButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView sd_addSubviews:@[self.image, self.titleLabel, self.concernButton, self.concernLabel]];
        self.concernButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.concernButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.concernButton addTarget:self action:@selector(clickConcernButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.concernButton.sd_layout
        .rightSpaceToView(self.contentView, margin)
        .widthIs(35)
        .heightIs(15)
        .centerYIs(self.width * 3 / 40 + margin);
        self.concernButton.backgroundColor = [UIColor colorWithRed:0.810 green:0.810 blue:0.000 alpha:1.000];
        self.concernButton.sd_cornerRadiusFromHeightRatio = @0.5;
        
        self.image.sd_layout
        .topSpaceToView(self.contentView, margin)
        .leftSpaceToView(self.contentView, 2 * margin)
        .widthIs(self.width * 3 / 20)
        .autoHeightRatio(1);
        
        self.titleLabel.sd_layout
        .topEqualToView(self.image)
        .leftSpaceToView(self.image, margin)
        .rightSpaceToView(self.concernButton, margin)
        .heightIs(self.width * 1 / 10);
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor colorWithWhite:0.324 alpha:1.000];
//        self.titleLabel.backgroundColor = [UIColor redColor];
        
        self.concernLabel.sd_layout
        .topSpaceToView(self.titleLabel, 0)
        .leftEqualToView(self.titleLabel)
        .heightIs(self.width * 1 / 20);
        [self.concernLabel setSingleLineAutoResizeWithMaxWidth:200];
        self.concernLabel.font = [UIFont systemFontOfSize:12];
        self.concernLabel.textColor = [UIColor colorWithWhite:0.687 alpha:1.000];
//        self.concernLabel.backgroundColor = [UIColor greenColor];
        
        [self setupAutoHeightWithBottomView:self.image bottomMargin:margin];
        
        isConcern = NO;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setConcernModel:(ConcernModel *)concernModel
{
    self.titleLabel.text = concernModel.title;
    self.concernLabel.text = concernModel.concernCount;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:concernModel.imageUrl] placeholderImage:[UIImage imageNamed:@"load"]];
    [self.concernButton setTitle:@"关注" forState:UIControlStateNormal];
}

- (void)clickConcernButtonAction:(UIButton *)sender
{
    if (!isConcern) {
        [self.concernButton setTitle:@"已关注" forState:UIControlStateNormal];
        self.concernButton.backgroundColor = [UIColor grayColor];
        isConcern = YES;
    }
    else
    {
        [self.concernButton setTitle:@"关注" forState:UIControlStateNormal];
        self.concernButton.backgroundColor = [UIColor colorWithRed:0.927 green:0.927 blue:0.000 alpha:1.000];
        isConcern = NO;
    }
        
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
