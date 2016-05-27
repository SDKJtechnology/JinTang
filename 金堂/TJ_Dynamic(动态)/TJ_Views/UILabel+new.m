//
//  UILabel+new.m
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "UILabel+new.h"

@implementation UILabel (new)

- (CGFloat)fontSize
{
    return self.font.pointSize;
}

- (void)setFontSize:(CGFloat)fontSize
{
    self.font = [UIFont systemFontOfSize:fontSize];
}

#pragma mark - 计算文本的的frame
- (CGRect)getLabelFrame
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.font;
    CGRect frame = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    return frame;
}
//设置label的真实宽度
- (void)setLabelTruthWidth{
    CGRect frame = self.frame;
    frame.size.width = [self getLabelFrame].size.width;
    self.frame = frame;
}

@end
