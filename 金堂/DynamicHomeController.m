//
//  ViewController.m
//  金堂
//
//  Created by zouxin on 16/3/28.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicHomeController.h"
#import "TJSelectionList.h"
#import <UIView+SDAutoLayout.h>
#import "DynamicNotImageCell.h"
#import "DynamicModel.h"
#import "DynamicNetworkingModel.h"

#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height

@interface DynamicHomeController ()
    <TJSelectionListDelegate,
    UITableViewDelegate,UITableViewDataSource
    ,UIScrollViewDelegate>
{
    NSArray *selectListData;//水平选择列表数据
    
    NSMutableArray *dynamicListData;
    
    CGFloat oldContentOffsetY;
}

@property (strong, nonatomic) UIScrollView *contentView;
@property (strong, nonatomic) TJSelectionList *selectList;//水平选择列表

@end

const CGFloat yNavigationBarBelow = 64;//NavigationBar下边Y坐标
const CGFloat selectListHeight = 40;//水平选择列表高度
const CGFloat tabBarHeight = 49;//tabBar高度
static NSNumber *page;

@implementation DynamicHomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    page = @1;
    selectListData = @[@"关注",@"热点",@"活动"];
    dynamicListData = [NSMutableArray array];
    [DynamicNetworkingModel sharedObejct].dynamicListBlock = ^(id data)
    {
        UITableView *tableView = [self.contentView viewWithTag:100];
        [dynamicListData addObjectsFromArray:data];
        [tableView reloadData];
        return YES;
    };
    [[DynamicNetworkingModel sharedObejct] getDynamicDataWithPage:page];
    
    self.selectList = [[TJSelectionList alloc] initWithFrame:CGRectMake(0, yNavigationBarBelow, VIEW_WIDTH, selectListHeight)];
    self.selectList.delegate = self;
    
    self.contentView = [[UIScrollView alloc] init];
    self.contentView.frame = CGRectMake(0, self.selectList.frame.size.height + yNavigationBarBelow, VIEW_WIDTH, VIEW_HEIGHT - yNavigationBarBelow - tabBarHeight - selectListHeight);
    self.contentView.showsVerticalScrollIndicator = NO;
    self.contentView.showsHorizontalScrollIndicator = NO;
    self.contentView.bounces = NO;
    self.contentView.delegate = self;
    
    [self.view insertSubview:self.selectList atIndex:1];
    [self.view insertSubview:self.contentView atIndex:0];
    
        //  添加TableView
        CGFloat w = self.contentView.frame.size.width;
        CGFloat h = self.contentView.frame.size.height;
    for (NSInteger i = 0; i < selectListData.count; i++) {     /* 有多View取决于categories的数量 */
        CGRect frame = self.contentView.bounds;
        frame.origin.x = i * VIEW_WIDTH;
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i + 100;
        [self.contentView insertSubview:tableView atIndex:0];
    }
    
    //  设置scrollView
    self.contentView.contentSize = CGSizeMake(selectListData.count * w, h);
    self.contentView.pagingEnabled = YES;
}

#pragma mark HTHorizontalSelectionListDataSource

- (NSInteger)numberOfItemsAtSelectionList:(TJSelectionList *)selectionList
{
    return selectListData.count;
}

- (NSString *)selectionList:(TJSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index
{
    return selectListData[index];
}

#pragma mark HTHorizontalSelectionListDelegate

- (void)selectionList:(TJSelectionList *)selectionList didSelectItemWithIndex:(NSInteger)index
{
    //  实现scrollView滑动绑定的方法
    CGRect frame = self.contentView.bounds;
    frame.origin.x = frame.size.width * index;
    [self.contentView scrollRectToVisible:frame animated:YES];
}

#pragma 实现UIScrollViewDelegate 的方法
//  实现scrollView滑动绑定的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    oldContentOffsetY = scrollView.contentOffset.y;
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.selectList.selectedItemIndex = page;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (scrollView.contentOffset.x == targetContentOffset->x && scrollView.contentOffset.y == targetContentOffset->y && targetContentOffset->x == 0) {
        [self openOrCloseLeftList];
    }
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModelTableViewCell *cell = nil;
    if (tableView.tag == 100)
    {
        NSString *identifier = [DynamicNotImageCell identifierForModelAtRow:dynamicListData[indexPath.row]];
        Class cellClass = NSClassFromString(identifier);
        if (!cell){
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.sd_indexPath = indexPath;
        cell.sd_tableView = tableView;
        return cell;
    }
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
            return dynamicListData.count;
            break;
        case 101:
            return 0;
            break;
        case 102:
            return 0;
            break;
    }
    return 0;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 100:
        {
            ((DynamicNotImageCell *)cell).dynamicList = dynamicListData[indexPath.row];
        }
            break;
        case 101:
            break;
        case 102:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 100:
        {
            // cell自适应设置
            DynamicList * model = dynamicListData[indexPath.row];
            
            NSString * identifier = [ModelTableViewCell identifierForModelAtRow:model];
            Class mClass =  NSClassFromString(identifier);
            
            // 返回计算出的cell高度（普通简化版方法，同样只需一步设置即可完成）
            return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"dynamicList" cellClass:mClass contentViewWidth:self.view.frame.size.width];
//            return 200;
        }
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
