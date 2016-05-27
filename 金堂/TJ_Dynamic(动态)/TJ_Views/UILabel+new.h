//
//  UILabel+new.h
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (new)

@property (nonatomic, assign) CGFloat fontSize;

- (CGRect)getLabelFrame;
/**
 *  设置Label的真实宽度（在上数据后调用）
 */
- (void)setLabelTruthWidth;

@end
