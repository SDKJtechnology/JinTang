//
//  ViewController.m
//  金堂
//
//  Created by zouxin on 16/3/28.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_DynamicHomeController.h"
#import "TJ_SelectionList.h"
#import <UIView+SDAutoLayout.h>
#import "DynamicConcernNotImageCell.h"
#import "DynamicModel.h"
#import "HotspotModel.h"
#import "ActivityModel.h"
#import "DynamicNetworkingModel.h"
#import "HotspotBigImageCell.h"
#import "AdCell.h"
#import "ActivityCell.h"
#import "TJ_HeaderView.h"

#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height

@interface TJ_DynamicHomeController ()
    <TJ_SelectionListDelegate,
    UITableViewDelegate,UITableViewDataSource
    ,UIScrollViewDelegate>
{
    /**
     *  水平选择列表数据
     */
    NSArray *selectListData;
    /**
     *  动态关注列表数据
     */
    NSMutableArray *dynamicConcernListData;
    /**
     *   动态热点数据
     */
    NSMutableArray *dynamciHotspotData;
    /**
     *  活动页数据
     */
    NSMutableArray *activityData;
}

@property (strong, nonatomic) UIScrollView *contentView;
@property (strong, nonatomic) TJ_SelectionList *selectList;//水平选择列表

@end

const CGFloat yNavigationBarBelow = 64;//NavigationBar下边Y坐标
const CGFloat selectListHeight = 40;//水平选择列表高度
const CGFloat tabBarHeight = 49;//tabBar高度
static NSNumber *page;

@implementation TJ_DynamicHomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"金堂有爱";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"sousuo"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:nil];
    
    page = @1;
    selectListData = @[@"关注",@"热点",@"活动"];
    dynamicConcernListData = [NSMutableArray array];
    dynamciHotspotData = [NSMutableArray array];
    
    //获取tableView数据
    [self getDynamicConcernData];
    [self getDynamicHotspotData];
    
    self.selectList = [[TJ_SelectionList alloc] initWithFrame:CGRectMake(0, yNavigationBarBelow, VIEW_WIDTH, selectListHeight)];
    self.selectList.delegate = self;
    self.selectList.seletedTitleColor = [UIColor blackColor];
    self.selectList.indicatorColor = [UIColor blueColor];
    self.selectList.titleColor = [UIColor grayColor];
//    [self.selectList setSelectItemBorderStyleWithCornerRadius:6 BorderWidth:5 BorderColor:[UIColor redColor]];
//    self.selectList.selectedItemIndex = 1;
    
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
        
        [tableView registerClass:[HotspotBigImageCell class] forCellReuseIdentifier:NSStringFromClass([HotspotBigImageCell class])];
        [tableView registerClass:[AdCell class] forCellReuseIdentifier:NSStringFromClass([AdCell class])];
        [tableView registerClass:[ActivityCell class] forCellReuseIdentifier:NSStringFromClass([ActivityCell class])];
    }
    
    //  设置scrollView
    self.contentView.contentSize = CGSizeMake(selectListData.count * w, h);
    self.contentView.pagingEnabled = YES;
}

- (void)getDynamicConcernData
{
    [[DynamicNetworkingModel sharedObejct] getDynamicDataWithPage:page success:^(id data) {
        [dynamicConcernListData addObjectsFromArray:data];
        UITableView *tableView = [self.contentView viewWithTag:100];
        [tableView reloadData];
    } failure:^(id data) {
        NSLog(@"动态关注数据加载失败。。。%@",data);
    }];
}

//获取动态热点数据
- (void)getDynamicHotspotData
{
    [[DynamicNetworkingModel sharedObejct] getHotspotDataWithPage:page success:^(id data) {
        [dynamciHotspotData addObjectsFromArray:data];
        UITableView *tableView = [self.contentView viewWithTag:101];
        [tableView reloadData];
    } failure:^(id data) {
        NSLog(@"动态热点数据加载失败。。。%@",data);
    }];
}

#pragma mark TJ_SelectionListDelegate

- (NSInteger)numberOfItemsAtSelectionList:(TJ_SelectionList *)selectionList
{
    return selectListData.count;
}

- (NSString *)selectionList:(TJ_SelectionList *)selectionList titleForItemWithIndex:(NSInteger)index
{
    return selectListData[index];
}

- (void)selectionList:(TJ_SelectionList *)selectionList didSelectItemWithIndex:(NSInteger)index
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
    if (![scrollView isKindOfClass:[UITableView class]])
    {
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.selectList.selectedItemIndex = page;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (scrollView.contentOffset.x == targetContentOffset->x && scrollView.contentOffset.y == targetContentOffset->y  && ![scrollView isKindOfClass:[UITableView class]] && targetContentOffset->x == 0) {
        [self openOrCloseLeftList];
    }
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView.tag == 100)
    {
        NSString *identifier = [DynamicConcernNotImageCell identifierForModelAtRow:dynamicConcernListData[indexPath.section]];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[DynamicConcernNotImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
    else if (tableView.tag == 101) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HotspotBigImageCell class]) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        if (indexPath.row == 0)
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AdCell class]) forIndexPath:indexPath];
        else
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ActivityCell class]) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (tableView.tag) {
        case 100:
            return dynamicConcernListData.count;
            break;
        case 101:
            return dynamciHotspotData.count;
            break;
        case 102:
            return 5;
            break;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 100:
            return 1;
            break;
        case 101:
            return 1;
            break;
        case 102:
            return 4;
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
            DynamicList *model = dynamicConcernListData[indexPath.section];
            ((DynamicConcernNotImageCell *)cell).dynamicList = model;
        }
            break;
        case 101:
        {
            HotspotModel *hots = dynamciHotspotData[indexPath.section];
            ((HotspotBigImageCell *)cell).header = hots.item.header;
        }
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
            DynamicList * model = dynamicConcernListData[indexPath.section];
            // 返回计算出的cell高度（普通简化版方法，同样只需一步设置即可完成）
            return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"dynamicList" cellClass:[DynamicConcernNotImageCell class] contentViewWidth:VIEW_WIDTH];
        }
            break;
        case 101:
        {
            HotspotModel *hots = dynamciHotspotData[indexPath.section];
            Body *body = hots.item.header;
            return [tableView cellHeightForIndexPath:indexPath model:body keyPath:@"header"cellClass:[HotspotBigImageCell class] contentViewWidth:VIEW_WIDTH];
        }
            break;
        case 102:
        {
            ActivityModel *model = nil;

            if (indexPath.row == 0)
            {
                return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"activityModel"cellClass:[AdCell class] contentViewWidth:VIEW_WIDTH];
            }
            return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"activityModel"cellClass:[ActivityCell class] contentViewWidth:VIEW_WIDTH];
        }
            break;
    }
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 102) {
        TJ_HeaderView *view = [[TJ_HeaderView alloc] initWithFrame:CGRectMake(110, 10, 100, 30)];
        return view;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 100:
            return 10;
            break;
        case 101:
            return 10;
            break;
        case 102:
            return 50;
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
            return 5;
            break;
        case 102:
            return 3;
            break;
    }
    return 0.01;
}

@end
