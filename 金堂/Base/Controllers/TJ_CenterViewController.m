
//
//  CenterNacigationController.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/4.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_CenterViewController.h"
#import "TJ_LeftSortsViewController.h"
#import "AppDelegate.h"

@interface TJ_CenterViewController()
{
    AppDelegate *tempAppDelegate;
}

@end

@implementation TJ_CenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:[[UIImage imageNamed:@"ren"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 30, 30);
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, 50, 30);
    [view addSubview:button];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    self.navigationItem.leftBarButtonItems = @[buttonItem];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.239 green:0.638 blue:0.955 alpha:1.000];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-BoldOblique" size:19],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    
    [self.view addGestureRecognizer:pan];
}

- (void)panAction:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self.view];
    NSLog(@"x = %f   y = %f",point.x,point.y);
    if (fabs(point.y) < 10 && point.x > 30 && tempAppDelegate.LeftSlideVC.closed)
    {
        [self openOrCloseLeftList];
    }
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    NSLog(@"viewDidAppear");
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}


@end
