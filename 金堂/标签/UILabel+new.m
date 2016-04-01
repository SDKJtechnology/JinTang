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

@end
