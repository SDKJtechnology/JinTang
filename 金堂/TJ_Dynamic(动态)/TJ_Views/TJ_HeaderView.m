//
//  TJ_HeaderView.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/14.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_HeaderView.h"

@implementation TJ_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.backgroundColor = [UIColor colorWithWhite:0.670 alpha:1.000];
        self.textLabel.font = [UIFont systemFontOfSize:17];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.layer.masksToBounds = YES;
        self.textLabel.layer.cornerRadius = 6;
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.textLabel.center = self.contentView.center;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
