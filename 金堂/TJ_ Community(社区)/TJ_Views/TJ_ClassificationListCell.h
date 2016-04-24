//
//  TJ_ClassificationListCell.h
//  金堂
//
//  Created by ZhangAnMing on 16/4/17.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDAutoLayout.h"
#import "CommunityModel.h"

@interface TJ_ClassificationListCell : UITableViewCell

@property (nonatomic, assign) BOOL hiddenConcernButton;

@property (nonatomic, strong) CommunityModel *communityModel;

@end
