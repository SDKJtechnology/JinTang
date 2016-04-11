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
    TJSelectionItemModeEqualWidth
};

@protocol TJ_SelectionListDelegate;

@interface TJ_SelectionList : UIView

@property (nonatomic) TJSelectionItemMode selectionItemStyle;

@property (nonatomic, weak) id<TJ_SelectionListDelegate> delegate;

@property (nonatomic, assign) NSInteger selectedItemIndex;

@end

@protocol TJ_SelectionListDelegate <NSObject>

- (NSInteger)numberOfItemsAtSelectionList:(TJ_SelectionList *)selectionList;

@optional
- (NSString *)selectionList:(TJ_SelectionList *)selectionList titleForItemWithIndex:(NSInteger)index;
- (void)selectionList:(TJ_SelectionList *)selectionList didSelectItemWithIndex:(NSInteger)index;

@end
