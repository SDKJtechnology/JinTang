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
        
        self.rightButton.sd_layout
        .widthIs(40);
        self.rightButton.sd_cornerRadius = @5;
        self.rightButton.layer.borderColor = [[UIColor greenColor] CGColor];
        self.rightButton.layer.borderWidth = 1;
        
        self.contentView.sd_equalWidthSubviews = _imageViewsArray;
        self.headerButton.sd_cornerRadiusFromHeightRatio = @.5;
        
        [self setupAutoHeightWithBottomView:leftV bottomMargin:margin];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

- (void)setModel:(SupportTarentoModel *)model
{
    for (NSInteger i = 0; i < _imageViewsArray.count; i++) {
        NSString *url = model.imagesArray[i];
        UIImageView *imageView = _imageViewsArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"load"]];
    }
    
    [self.headerButton sd_setImageWithURL:[NSURL URLWithString:model.userImageUrl] forState:UIControlStateNormal];
    
    [self.nameButton setTitle:model.userNameString forState:UIControlStateNormal];
    [self.nameButton setButtonTruthWidth];
    
    self.sexImageView.image = [UIImage imageNamed:@"nv"];
    
    self.timeLabel.text = model.detailString;
}

@end
