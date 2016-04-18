//
//  LeftSortsViewController.h
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJ_LeftSlideViewController.h"

typedef NS_ENUM(NSInteger,TJ_BACustomButtonTag)
{
    /**
     *  登陆
     */
    TJ_BACustomButtonTagLandingButton     = 0,
    /**
     *  关注
     */
    TJ_BACustomButtonTagConcernButton     = 1,
    /**
     *  粉丝
     */
    TJ_BACustomButtonTagFansButton        = 2,
    /**
     *  圈子
     */
    TJ_BACustomButtonTagCircleButton      = 3,
    /**
     *  帖子
     */
    TJ_BACustomButtonTagInvitationButton  = 4,
    /**
     *  收藏
     */
    TJ_BACustomButtonTagEnshrineButton    = 5,
    /**
     *  设置
     */
    TJ_BACustomButtonTagSetingButton      = 6,
    /**
     *  注册
     */
    TJ_BACustomButtonTagLogingButton      = 7
};

typedef void(^CloseLeftVC)(UIViewController *);

@interface TJ_LeftSortsViewController : UIViewController

@property (nonatomic, strong) CloseLeftVC closeLeftVC;
@end
