//
//  TJSelectionListCell.h
//  金堂
//
//  Created by ZhangAnMing on 16/4/6.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJ_SelectionListCell : UICollectionViewCell

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign) NSString *titleSting;

@property (nonatomic, strong) UIColor *indicatorColor;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *seletedTitleColor;

@property (nonatomic, strong) UIColor *backgroundColor;

- (void)setBorderStyleWithCornerRadius:(CGFloat)cornerRadius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)borderColor;

- (void)setDidSelectedItemBorderStyleWithCornerRadius:(CGFloat)cornerRadius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)borderColor;

@end
