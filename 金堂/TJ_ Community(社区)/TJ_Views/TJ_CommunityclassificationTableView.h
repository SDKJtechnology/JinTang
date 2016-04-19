//
//  TJ_ClassificationTableView.h
//  金堂
//
//  Created by ZhangAnMing on 16/4/17.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJ_CommunityclassificationTableView : UITableView

@property (nonatomic, strong) UIColor *textLabelTextColor;

@property (nonatomic, strong) UIColor *selectTextLabelTextColor;

@end

@interface TJ_CommunityclassificationTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *indicatorView;

@end
