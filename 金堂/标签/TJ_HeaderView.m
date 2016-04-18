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
        self.dateLabel = [UILabel new];
        [self addSubview:self.dateLabel];
        self.dateLabel.frame = CGRectMake(0, 10, 50, 30);
        CGPoint p = self.dateLabel.center;
        p.x = [UIScreen mainScreen].bounds.size.width / 2;
        self.dateLabel.center = p;
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        self.dateLabel.backgroundColor = [UIColor grayColor];
        self.dateLabel.font = [UIFont systemFontOfSize:17];
        self.dateLabel.textColor = [UIColor blackColor];
        self.dateLabel.layer.masksToBounds = YES;
        self.dateLabel.layer.cornerRadius = 6;
        self.dateLabel.text = @"4/12";
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
