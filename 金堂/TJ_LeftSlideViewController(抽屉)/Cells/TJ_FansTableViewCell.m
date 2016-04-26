//
//  TJ_FansTableView.m
//  金堂
//
//  Created by SDKJ on 16/4/26.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_FansTableViewCell.h"

@implementation TJ_FansTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setImage:[[UIImage imageNamed:@"liaotian1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.sd_layout
        .topSpaceToView(self.contentView, 5)
        .bottomSpaceToView(self.contentView, 5)
        .rightSpaceToView(self.contentView, 10)
        .widthIs(50);
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor colorWithWhite:0.727 alpha:1.000];
        [self.contentView addSubview:lineView];
        
        lineView.sd_layout
        .xIs(5)
        .widthIs(Screen_Width - 10)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        self.imageView.sd_layout
        .topSpaceToView(self.contentView, 5)
        .bottomSpaceToView(self.contentView, 5)
        .widthEqualToHeight();
        self.imageView.layer.masksToBounds = YES;
        self.imageView.sd_cornerRadiusFromWidthRatio = @0.5;
        
        self.textLabel.font = [UIFont fontWithName:TJFont size:15];
        self.textLabel.textColor = [UIColor colorWithRed:0.261 green:0.508 blue:0.892 alpha:1.000];
        self.textLabel.sd_layout.leftSpaceToView(self.imageView, 10);

        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)clickButtonAction:(UIButton *)sender
{
    NSLog(@"%@",self.textLabel.text);
}

@end
