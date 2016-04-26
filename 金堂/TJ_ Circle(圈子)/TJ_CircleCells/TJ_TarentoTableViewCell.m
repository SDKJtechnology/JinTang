//
//  TJ_TarentoTableViewCell.m
//  金堂
//
//  Created by SDKJ on 16/4/25.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_TarentoTableViewCell.h"
#import "SDAutoLayout.h"

@interface TJ_TarentoTableViewCell()

@property (nonatomic, strong) NSMutableArray *imageViewsArray;

@end

@implementation TJ_TarentoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imageViewsArray = [NSMutableArray array];
        NSArray *colorArray = @[[UIColor greenColor],[UIColor orangeColor],[UIColor cyanColor],[UIColor blueColor]];
        UIView *leftV = self.contentView;
        
        for (NSInteger i = 0; i < 4; i++) {
            UIImageView *imageView = [UIImageView new];
            imageView.backgroundColor = colorArray[i];
            [self.contentView addSubview:imageView];
            [_imageViewsArray addObject:imageView];
            
            imageView.sd_layout
            .topSpaceToView(self.headerButton, margin)
            .leftSpaceToView(leftV, margin)
            .autoHeightRatio(1);
            if (i == 3) {
                imageView.sd_layout.rightSpaceToView(self.contentView, margin);
            }
            
            leftV = imageView;
        }
        
        self.identifierImage = [UIImageView new];
        [self.contentView addSubview:self.identifierImage];
        
        self.identifierImage.sd_layout
        .topEqualToView(leftV)
        .leftSpaceToView(self.contentView, margin)
        .heightRatioToView(leftV, 0.4)
        .widthEqualToHeight();
        [self.contentView bringSubviewToFront:self.identifierImage];
        
        [self.rightButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.contentView.sd_equalWidthSubviews = _imageViewsArray;
        self.headerButton.sd_cornerRadiusFromHeightRatio = @.5;
        
        [self setupAutoHeightWithBottomView:leftV bottomMargin:margin];
    }
    
    return self;
}

- (void)clickButtonAction:(TJ_BACustomButton *)sender
{
    static BOOL isOk = NO;
    if (isOk) {
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"liaotian1"] forState:UIControlStateNormal];
        isOk = NO;
    }
    else
    {
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"guanzhu"] forState:UIControlStateNormal];
        isOk = YES;
    }
}

- (void)setModel:(SupportTarentoModel *)model
{
    for (NSInteger i = 0; i < _imageViewsArray.count; i++) {
        NSString *url = model.imagesArray[i];
        UIImageView *imageView = _imageViewsArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"load"]];
    }
    static BOOL isOk = NO;
    if (isOk) {
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"liaotian1"] forState:UIControlStateNormal];
    }
    else
    {
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"guanzhu"] forState:UIControlStateNormal];
        isOk = YES;
    }
    [self.rightButton setButtonTruthWidth];
    
    [self.headerButton sd_setImageWithURL:[NSURL URLWithString:model.userImageUrl] forState:UIControlStateNormal];
    
    [self.nameButton setTitle:model.userNameString forState:UIControlStateNormal];
    [self.nameButton setButtonTruthWidth];
    
    self.sexImageView.image = [UIImage imageNamed:@"nv"];
    
    self.timeLabel.text = model.detailString;
}

@end
