//
//  Tj_TopicTableViewCell.h
//  金堂
//
//  Created by SDKJ on 16/4/15.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJ_TableViewCellModel.h"
#import "TopicModel.h"

@interface TJ_TopicTableViewCell : TJ_TableViewCellModel

@property (nonatomic) UIImageView *identifierImage;

@property (nonatomic) UILabel *identifierLabel;

@property (nonatomic) UIImageView *shareImage1;

@property (nonatomic) UIImageView *shareImage2;

@property (nonatomic) TopicModel *topicModel;

@end

@interface Tj_TopicNotIdentifierImageCell : TJ_TopicTableViewCell

@end
