//
//  HotspotBigImageCell.h
//  金堂
//
//  Created by ZhangAnMing on 16/4/11.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
#import "SDAutoLayout.h"
#import <UIImageView+WebCache.h>

@interface ActivityBigImageCell : UITableViewCell

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIButton *activityButton;
@property (nonatomic, strong) Body *header;

@end
