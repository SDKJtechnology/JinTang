//
//  LX_HeaderView.m
//  金堂
//
//  Created by zouxin on 16/5/5.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "LX_HeaderView.h"

@implementation LX_HeaderView
-(id)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(40, 40, 200, 200)];
        view.backgroundColor = [UIColor redColor];
        [self addSubview:view];
        
    }
    return self;
}

@end
