//
//  TJSelectionList.h
//  金堂
//
//  Created by ZhangAnMing on 16/4/6.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TJSelectionItemMode)
{
    TJSelectionItemModeEqualWidth//等宽模式
};

@protocol TJ_SelectionListDelegate;

@interface TJ_SelectionList : UIView
/**
 *  title字体
 */
@property (nonatomic, strong) UIFont *font;
/**
 *  选择项模式
 */
@property (nonatomic) TJSelectionItemMode selectionItemMode;
/**
 *  选项title
 */
@property (nonatomic, assign) NSString *titleSting;
/**
 *  指示器颜色,默认为灰色
 */
@property (nonatomic, strong) UIColor *indicatorColor;
/**
 *  title颜色,默认为黑色
 */
@property (nonatomic, strong) UIColor *titleColor;
/**
 *  选中的title颜色,默认为灰色
 */
@property (nonatomic, strong) UIColor *seletedTitleColor;
/**
 *  背景颜色，默认为白色
 */
@property (nonatomic, strong) UIColor *backgroundColor;
/**
 *  选项按钮背景颜色,默认为白色
 */
@property (nonatomic, strong) UIColor *selectItemBackgroundColor;

@property (nonatomic, weak) id<TJ_SelectionListDelegate> delegate;
/**
 *  选择的索引,默认为0
 */
@property (nonatomic, assign) NSInteger selectedItemIndex;
/**
 *  设置已经选中的选项按钮边框样式，默认无边框
 *
 *  @param cornerRadius                 边框角度
 *  @param borderWidth                  边框宽度
 *  @param borderColor                边框颜色
 */
- (void)setDidSelectedItemBorderStyleWithCornerRadius:(CGFloat)cornerRadius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)borderColor;
/**
 *  设置所有选项按钮边框样式，默认无边框
 *
 *  @param cornerRadius                 边框角度
 *  @param borderWidth                  边框宽度
 *  @param borderColor                边框颜色
 */
- (void)setSelectItemBorderStyleWithCornerRadius:(CGFloat)cornerRadius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)borderColor;
/**
 *  设置选项列表边框样式，默认无边框
 *
 *  @param cornerRadius                 边框角度
 *  @param borderWidth                  边框宽度
 *  @param borderColor                边框颜色
 */
- (void)setBorderStyleWithCornerRadius:(CGFloat)cornerRadius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)borderColor;

@end

@protocol TJ_SelectionListDelegate <NSObject>
/**
 *  设置选项数量
 *
 *  @param selectionList 当前选项列表
 *
 *  @return 选项数量
 */
- (NSInteger)numberOfItemsAtSelectionList:(TJ_SelectionList *)selectionList;

@optional
/**
 *  设置选项title
 *
 *  @param selectionList 当前选项列表
 *  @param index         选项索引（tag）
 *
 *  @return title字符串
 */
- (NSString *)selectionList:(TJ_SelectionList *)selectionList titleForItemWithIndex:(NSInteger)index;
/**
 *  当选中某一项时执行
 *
 *  @param selectionList 当前选项列表
 *  @param index  选中项的索引
 */
- (void)selectionList:(TJ_SelectionList *)selectionList didSelectItemWithIndex:(NSInteger)index;

@end

