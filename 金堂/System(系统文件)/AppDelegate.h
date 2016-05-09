//
//  AppDelegate.h
//  金堂
//
//  Created by zouxin on 16/3/28.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJ_LeftSlideViewController.h"
#import "UMSocialControllerService.h"
#define UmengAppkey @"53290df956240b6b4a0084b3"
#import <WeiboSDK.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>{
    NSString *wbtoken;
    NSString *wbCurrentUserID;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TJ_LeftSlideViewController *LeftSlideVC;
@property (strong, nonatomic) UINavigationController *mainNavigationController;

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbRefreshToken;
@property (strong, nonatomic) NSString *wbCurrentUserID;
@end

