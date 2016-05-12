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
    self.sharedPhotoView.userInteractionEnabled = NO;
    
    self.nameButton.sd_layout
    .topSpaceToView(self.sharedPhotoView, margin / 2)
    .leftEqualToView(self.titleLabel)
    .widthIs(150)
    .heightIs(20);
    [self.nameButton setTitleColor:self.browseCountButton.currentTitleColor forState:UIControlStateNormal];
    self.nameButton.enabled = NO;
    
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
    self.browseCountButton.enabled = NO;
    
    UIView *lineView = [UIView new];
    [self.contentView addSubview:lineView];
    lineView.sd_layout
    .topSpaceToView(self.browseCountButton, margin / 2)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(0.5);
    lineView.backgroundColor = [UIColor grayColor];
    
    [self setupAutoHeightWithBottomView:lineView bottomMargin:0];
}

- (void)setDynamicConcernsModel:(DynamicConcernsModel *)dynamicConcernsModel
{
    [self.nameButton setTitle:dynamicConcernsModel.name forState:UIControlStateNormal];
    [self.nameButton setButtonTruthWidth];
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (Image *image in dynamicConcernsModel.imagesUrl) {
        [imageArray addObject:image.imageUrl];
    }
    self.sharedPhotoView.imageUrlArray = imageArray;
    self.titleLabel.text = dynamicConcernsModel.title;
        
    self.timeLabel.text = dynamicConcernsModel.createDate;
    
    [self.browseCountButton setTitle:[NSString stringWithFormat:@"%@",dynamicConcernsModel.readNumber] forState:UIControlStateNormal];
    [self.browseCountButton setButtonTruthWidth];
}

+ (NSString *)identifierForModelAtRow:(id)Model
{
    DynamicConcernsModel *model = Model;
    switch (model.imagesUrl.count) {
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
