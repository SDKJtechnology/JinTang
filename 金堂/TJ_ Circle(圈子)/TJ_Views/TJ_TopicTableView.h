//
//  TJ_TopicTableView.h
//  金堂
//
//  Created by SDKJ on 16/4/15.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  TJ_TopicTableViewDelegate;

@interface TJ_TopicTableView : UITableView

@property (nonatomic, strong) id<TJ_TopicTableViewDelegate> delegateTopic;

@property (nonatomic) NSArray *topicData;

@end

@protocol  TJ_TopicTableViewDelegate

- (void)didClickNavigationButtonAtTitel:(NSString *)title;

@end
