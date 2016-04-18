//
//  TJ_GachincoTableViewCell.h
//  金堂
//
//  Created by ZhangAnMing on 16/4/16.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJ_TableViewCellModel.h"
#import "GachincoModel.h"
#import "TJ_CommetView.h"

@interface TJ_GachincoTableViewCell : TJ_TableViewCellModel

@property (nonatomic, strong) TJ_BACustomButton *shareButton;

@property (nonatomic, strong) GachincoModel *gachincoModel;


@property (nonatomic, strong) TJ_CommetView *commetView;

@end
