//
//  TJ_TopicNavigationTableViewCell.h
//  金堂
//
//  Created by SDKJ on 16/4/22.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TJ_TopicNavigationButtonTag) {

    TJ_TopicNavigationNewTopicButtonTag = 20,

    TJ_TopicNavigationMyTopicButtonTag
};

@protocol TJ_TopicNavigationTableViewCellDelegate;
/**
 *  话题导航选项cell
 */
@interface TJ_TopicNavigationTableViewCell : UITableViewCell

@property (nonatomic, weak) id<TJ_TopicNavigationTableViewCellDelegate> delegate;

@end

@protocol TJ_TopicNavigationTableViewCellDelegate

- (void)didClickTopicNavigationButton:(TJ_TopicNavigationTableViewCell *)cell Titel:(NSString *)title;
@end
