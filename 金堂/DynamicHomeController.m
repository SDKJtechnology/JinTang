//
//  ViewController.m
//  金堂
//
//  Created by zouxin on 16/3/28.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicHomeController.h"
#import "HTHorizontalSelectionList.h"
#import <UIView+SDAutoLayout.h>

#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height

@interface DynamicHomeController ()<HTHorizontalSelectionListDataSource,HTHorizontalSelectionListDelegate,
    UITableViewDelegate,UITableViewDataSource
    ,UIScrollViewDelegate>
{
    NSArray *selectListData;//水平选择列表数据
}

@property (strong, nonatomic) IBOutlet UIScrollView *contentView;
@property (strong, nonatomic) IBOutlet HTHorizontalSelectionList *selectList;//水平选择列表

@end

const CGFloat yNavigationBarBelow = 64;//NavigationBar下边Y坐标
const CGFloat selectListHeight = 40;//水平选择列表高度
const CGFloat tabBarHeight = 49;//tabBar高度

@implementation DynamicHomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    selectListData = @[@"关注",@"热点",@"活动"];
    
    self.selectList = [[HTHorizontalSelectionList alloc] init];
    self.selectList.frame = CGRectMake(0, yNavigationBarBelow, VIEW_WIDTH, selectListHeight);
    [self.view addSubview:self.selectList];
    
    self.contentView = [[UIScrollView alloc] init];
    self.contentView.frame = CGRectMake(0, self.selectList.frame.size.height + yNavigationBarBelow, VIEW_WIDTH, VIEW_HEIGHT - yNavigationBarBelow - tabBarHeight - selectListHeight);
    self.contentView.delegate = self;
    [self.view addSubview:self.contentView];
    
        //  添加TableView
        CGFloat w = self.contentView.frame.size.width;
        CGFloat h = self.contentView.frame.size.height;
    for (NSInteger i = 0; i < selectListData.count; i++) {     /* 有多View取决于categories的数量 */
        CGRect frame = self.contentView.bounds;
        frame.origin.x = i * VIEW_WIDTH;
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i + 100;
        [self.contentView addSubview:tableView];
    }
    
    //  设置scrollView
    self.contentView.contentSize = CGSizeMake(selectListData.count * w, h);
    self.contentView.pagingEnabled = YES;
    
    [self.selectList setSelectionIndicatorColor:[UIColor blackColor]];
    [self.selectList setTitleFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16] forState:UIControlStateNormal];
    [self.selectList setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.selectList setSelectionIndicatorColor:[UIColor blueColor]];
    self.selectList.delegate = self;
    self.selectList.dataSource = self;
}

#pragma mark HTHorizontalSelectionListDataSource

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList
{
    return selectListData.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index
{
    return selectListData[index];
}

#pragma mark HTHorizontalSelectionListDelegate

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index
{
    //  实现scrollView滑动绑定的方法
    CGRect frame = self.contentView.bounds;
    frame.origin.x = frame.size.width * index;
    [self.contentView scrollRectToVisible:frame animated:YES];
}

#pragma 实现UIScrollViewDelegate 的方法
//  实现scrollView滑动绑定的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.selectList.selectedButtonIndex = page;
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = @"12";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (tableView.tag) {
        case 100:
            return 1;
            break;
        case 101:
            return 2;
            break;
        case 102:
            return 3;
            break;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 100:
            return 10;
            break;
        case 101:
            return 2;
            break;
        case 102:
            return 3;
            break;
    }
    return 2;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 100:
            return 100;
            break;
        case 101:
            return 2;
            break;
        case 102:
            return 3;
            break;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 100:
            return 0.01;
            break;
        case 101:
            return 2;
            break;
        case 102:
            return 3;
            break;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    switch (tableView.tag) {
        case 100:
            return 0.01;
            break;
        case 101:
            return 2;
            break;
        case 102:
            return 3;
            break;
    }
    return 0.01;
}

@end
