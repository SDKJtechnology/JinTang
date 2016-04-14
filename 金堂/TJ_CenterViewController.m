
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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ren"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(openOrCloseLeftList)];
//    self.title = @"金堂之家";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.239 green:0.638 blue:0.955 alpha:1.000];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-BoldOblique" size:19],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
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
