//
//  Tj_TopicTableViewCell.h
//  金堂
//
//  Created by SDKJ on 16/4/15.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"
/**
 *  话题cell
 */
@interface TJ_TopicTableViewCell : UITableViewCell

@property (nonatomic) UIImageView *identifierImage;

@property (nonatomic) TopicModel *topicModel;

@end
