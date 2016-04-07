
//
//  CenterNacigationController.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/4.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "CenterViewController.h"
#import "LeftSortsViewController.h"
#import "AppDelegate.h"

@interface CenterViewController()
{
    AppDelegate *tempAppDelegate;
}

@end

@implementation CenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dongtai.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openOrCloseLeftList)];
    self.title = @"金堂之家";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.239 green:0.638 blue:0.955 alpha:1.000];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-BoldOblique" size:19],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void) openOrCloseLeftList
{
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    NSLog(@"viewWillDisappear");
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear");
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}


@end
