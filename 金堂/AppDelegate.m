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

@interface AppDelegate ()

@end

@implementation AppDelegate

//禁止横屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSArray *imageNames = @[@"dongtai.png",@"shequ",@"quan",@"liaotian",@"faxian"];
    NSArray *titles = @[@"动态",@"社区",@"金堂圈",@"聊天",@"发现"];
    NSArray *calssArray = @[@"TJ_DynamicHomeController",@"TJ_DynamicHomeController",@"TJ_DynamicHomeController",@"TJ_DynamicHomeController",@"TJ_DynamicHomeController"];
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
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor grayColor];
    self.window.rootViewController = self.LeftSlideVC;
    [self.window makeKeyAndVisible];
    
    return YES;
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
