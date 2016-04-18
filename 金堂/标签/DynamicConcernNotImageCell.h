//
//  ModelTableViewCell.h
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"
#import "TJ_TableViewCellModel.h"

@interface DynamicConcernNotImageCell : TJ_TableViewCellModel
/**
 *   数据模型
 */
@property (nonatomic, strong) DynamicList *dynamicList;

@end

