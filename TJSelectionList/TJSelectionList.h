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

@protocol TJSelectionListDelegate;

@interface TJSelectionList : UIView

@property (nonatomic) TJSelectionItemMode selectionItemStyle;

@property (nonatomic, weak) id<TJSelectionListDelegate> delegate;

@property (nonatomic, assign) NSInteger selectedItemIndex;

@end

@protocol TJSelectionListDelegate <NSObject>

- (NSInteger)numberOfItemsAtSelectionList:(TJSelectionList *)selectionList;

@optional
- (NSString *)selectionList:(TJSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index;
- (void)selectionList:(TJSelectionList *)selectionList didSelectItemWithIndex:(NSInteger)index;

@end
