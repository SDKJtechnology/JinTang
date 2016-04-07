//
//  TJSelectionListCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/6.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJSelectionListCell.h"
#import "UIView_extra.h"

@interface TJSelectionListCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation TJSelectionListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor grayColor];
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
    self.indicatorView.frame = CGRectMake(5, self.height - height, self.width - 10, 3);
//    self.indicatorView.backgroundColor = [UIColor blueColor];
    self.titleLabel.frame = CGRectMake(0, 0, self.width, self.height - self.indicatorView.height);
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

@end
