//
//  TJSelectionListCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/6.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_SelectionListCell.h"
#import "UIView_extra.h"

@interface TJ_SelectionListCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation TJ_SelectionListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:18];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.indicatorView = [[UIView alloc] init];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.indicatorView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height = 3;
    self.indicatorView.frame = CGRectMake(5, self.height - height, self.width - 10, height);
//    self.indicatorView.backgroundColor = [UIColor blueColor];
    self.titleLabel.frame = CGRectMake(0, 0, self.width, self.height);
}

- (void)setTitleSting:(NSString *)titleSting
{
    self.titleLabel.text = titleSting;
}

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.indicatorView.backgroundColor = indicatorColor;
    });
}

- (void)setSeletedTitleColor:(UIColor *)seletedTitleColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.titleLabel.textColor = seletedTitleColor;
    });
}

- (void)setTitleColor:(UIColor *)titleColor
{
    self.titleLabel.textColor = titleColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.titleLabel.backgroundColor = backgroundColor;
}

- (void)setFont:(UIFont *)font
{
    self.titleLabel.font = font;
}

- (void)setBorderStyleWithCornerRadius:(CGFloat)cornerRadius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)borderColor
{
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.layer.cornerRadius = cornerRadius;
    self.titleLabel.layer.borderWidth = borderWidth;
    self.titleLabel.layer.borderColor = [borderColor CGColor];
}

- (void)setDidSelectedItemBorderStyleWithCornerRadius:(CGFloat)cornerRadius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)borderColor
{
    [self setBorderStyleWithCornerRadius:cornerRadius BorderWidth:borderWidth BorderColor:borderColor];
}

@end
