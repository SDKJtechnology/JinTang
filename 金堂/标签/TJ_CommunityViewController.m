//
//  TJ_CommunityViewController.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/16.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_CommunityViewController.h"
#import "TJ_CommunityclassificationTableView.h"
#import "TJ_ClassificationListTableView.h"

@interface TJ_CommunityViewController ()

@property (nonatomic, strong) TJ_ClassificationListTableView *classificationListView;

@property (nonatomic, strong) TJ_CommunityclassificationTableView *classificationView;

@end

@implementation TJ_CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"全部分类";
    
    CGFloat y = statusBarFrame.size.height + navigationBarFrame.size.height;
    CGFloat height = self.view.height - self.tabBarController.tabBar.height - y;
    
    self.classificationView = [[TJ_CommunityclassificationTableView alloc] initWithFrame:CGRectMake(0, y, self.view.width * 2 / 5, height) style:UITableViewStylePlain];
    self.classificationView.textLabelTextColor = [UIColor grayColor];
    self.classificationView.selectTextLabelTextColor = self.navigationController.navigationBar.barTintColor;
    [self.view addSubview:self.classificationView];
    [self.classificationView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.classificationView.delegate tableView:self.classificationView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    
    self.classificationListView = [[TJ_ClassificationListTableView alloc] initWithFrame:CGRectMake(self.classificationView.width, y, self.view.width - self.classificationView.width, height) style:UITableViewStylePlain];
    [self.view addSubview:self.classificationListView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
