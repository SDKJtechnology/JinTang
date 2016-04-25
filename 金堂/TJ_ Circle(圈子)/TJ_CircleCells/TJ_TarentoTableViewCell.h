//
//  TJ_TarentoTableViewCell.h
//  金堂
//
//  Created by SDKJ on 16/4/25.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJ_TableViewCellModel.h"
#import "SupportTarentoModel.h"
/**
 *  达人列表（点赞列表）
 */
@interface TJ_TarentoTableViewCell : TJ_TableViewCellModel

@property (nonatomic, strong) SupportTarentoModel *model;

@property (nonatomic) UIImageView *identifierImage;

@end
