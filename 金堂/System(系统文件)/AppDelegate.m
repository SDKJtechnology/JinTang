//
//  AppDelegate.m
//  金堂
//
//  Created by zouxin on 16/3/28.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "AppDelegate.h"
#import "TJ_LeftSortsViewController.h"
#import "TJ_DynamicHomeController.h"
#import "TJ_CycleScrollView.h"
#import <SMS_SDK/SMSSDK.h>
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import <RongIMKit/RongIMKit.h>
#import "LX_login2ViewController.h"
#import <RongIMLib/RongIMLib.h>
#define kUMKey    @"5657f8a367e58e3b660032d7"

#define kWXKey    @"wx945b58aef3a271f0"
#define kWXSecret   @"0ae78dd42761fd9681b04833c79a857b"

//SMSSDK官网公共key
#define appkey @"1141b32ced8e6"
#define app_secrect @"4ac3a62626f3d41e2c75e83bce6fb814"

#define kUMKey    @"5657f8a367e58e3b660032d7"

#define RONGCLOUD_IM_APPKEY @"z3v5yqkbv8v30" //1请换成您的appkey

@interface AppDelegate ()

@end

@implementation AppDelegate

//禁止横屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //初始化融云SDK
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    
    
    
    // Override point for customization after application launch.
    [UMSocialData setAppKey:kUMKey];
    /*苹果审核要求,隐藏未安装的应用 的分享选项 */
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    //  添加微信分享授权
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:kWXKey appSecret:kWXSecret url:@"http://www.umeng.com/social"];
    /*注册QQ登录授权*/
    [UMSocialQQHandler setQQWithAppId:@"1104539912" appKey:@"eFVgRits2fqf36Jf" url:@"http://www.umeng.com/social"];
    
    [SMSSDK registerApp:appkey
             withSecret:app_secrect];
    
    NSArray *imageNames = @[@"dongtai.png",@"shequ",@"quan",@"liaotian",@"faxian"];
    NSArray *titles = @[@"动态",@"社区",@"金堂圈",@"聊天",@"发现"];
    NSArray *calssArray = @[@"TJ_DynamicHomeController",@"TJ_CommunityViewController",@"TJ_CircleViewController",@"LX_loginViewController",@"LX_foundViewController"];
    NSMutableArray *VCArray = [NSMutableArray array];
    NSInteger i = 0;
    
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    
    for (NSString *className in calssArray) {
        Class myCallss = NSClassFromString(className);
        self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:[myCallss new]];
        UITabBarItem *tabBatItem = [[UITabBarItem alloc] initWithTitle:titles[i] image:[UIImage imageNamed:imageNames[i]] tag:i];
        self.mainNavigationController.tabBarItem = tabBatItem;
        [VCArray addObject:self.mainNavigationController];
        i++;
    }
    tabBarVC.viewControllers = VCArray;
    TJ_LeftSortsViewController *leftVCList = [[TJ_LeftSortsViewController alloc] init];
    self.LeftSlideVC = [[TJ_LeftSlideViewController alloc] initWithLeftView:leftVCList andMainView:tabBarVC];
    
    __block typeof(self) waekSelf = self;
    leftVCList.closeLeftVC = ^(UIViewController *vc)
    {
        [waekSelf.LeftSlideVC closeLeftView];
    };
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor grayColor];
    self.window.rootViewController = self.LeftSlideVC;
    [self.window makeKeyAndVisible];

    //添加启动页
//    TJ_CycleScrollView *startView = [[TJ_CycleScrollView alloc] initWithFrame:self.window.bounds];
//    startView.cycleModel = TJ_CycleScrollViewStartPageModel;
//    startView.imageGroup = @[@"start",@"start2"];
//    startView.imageUrlGroup = @[@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png",@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png",@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png"];
//    [self.window addSubview:startView];
//    [self.window bringSubviewToFront:startView];
    

    return YES;
}

/**2
 *  将得到的devicetoken 传给融云用于离线状态接收push ，您的app后台要上传推送证书
 *
 *  @param application <#application description#>
 *  @param deviceToken <#deviceToken description#>
 */

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}

//监听网络状态的变化
/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"您"
                              @"的帐号在别的设备上登录，您被迫下线！"
                              delegate:nil
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
       
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
