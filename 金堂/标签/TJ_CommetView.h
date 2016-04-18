//
//  TJ_CommetView.h
//  金堂
//
//  Created by ZhangAnMing on 16/4/16.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDAutoLayout.h"
#import "TJ_BAButton.h"

@interface TJ_CommetView : UIView

@property (nonatomic, strong) UILabel *commentLable;

@property (nonatomic, strong) TJ_BACustomButton *commetPersonButton;

@property (nonatomic, strong) NSArray *commetData;

@end
