//
//  ViewController.m
//  金堂
//
//  Created by zouxin on 16/3/28.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_DynamicHomeController.h"
#import "TJ_SelectionList.h"
#import "DynamicNetworkingModel.h"
#import "TJ_DynamicSearchController.h"
#import "TJ_DynamicConcernTableView.h"
#import "TJ_DynamicHotspotTableView.h"
#import "TJ_DynamicActivityTableView.h"

#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height

@interface TJ_DynamicHomeController ()<TJ_SelectionListDelegate,UIScrollViewDelegate>
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

@property (nonatomic, strong) TJ_DynamicConcernTableView *dynamicConcernTableView;

@property (nonatomic, strong) TJ_DynamicHotspotTableView *dynamicHotspotTableView;

@property (nonatomic, strong) TJ_DynamicActivityTableView *dynamicActivityTableView;

@end

const CGFloat yNavigationBarBelow = 64;//NavigationBar下边Y坐标
const CGFloat selectListHeight = 40;//水平选择列表高度
const CGFloat tabBarHeight = 49;//tabBar高度
static NSNumber *page;

@implementation TJ_DynamicHomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"金堂有爱";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"sousuo"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(clickRigthButtonAction)];
    
    page = @1;
    selectListData = @[@"关注",@"热点",@"活动"];
    dynamicConcernListData = [NSMutableArray array];
    dynamciHotspotData = [NSMutableArray array];
    
    //获取tableView数据
    [self getDynamicConcernData];
    [self getDynamicHotspotData];
    
    [self setup];
}

- (void)setup
{
    self.selectList = [[TJ_SelectionList alloc] initWithFrame:CGRectMake(0, yNavigationBarBelow, VIEW_WIDTH, selectListHeight)];
    self.selectList.delegate = self;
    self.selectList.seletedTitleColor = [UIColor blackColor];
    self.selectList.indicatorColor = [UIColor blueColor];
    self.selectList.titleColor = [UIColor grayColor];
    
    self.contentView = [[UIScrollView alloc] init];
    self.contentView.frame = CGRectMake(0, self.selectList.frame.size.height + yNavigationBarBelow, VIEW_WIDTH, VIEW_HEIGHT - yNavigationBarBelow - tabBarHeight - selectListHeight);
    self.contentView.showsVerticalScrollIndicator = NO;
    self.contentView.showsHorizontalScrollIndicator = NO;
    self.contentView.canCancelContentTouches = NO;
    self.contentView.delaysContentTouches = NO;
    self.contentView.bounces = NO;
    self.contentView.delegate = self;
    
    [self.view insertSubview:self.selectList atIndex:1];
    [self.view insertSubview:self.contentView atIndex:0];
    
    //  添加TableView
    CGFloat w = self.contentView.frame.size.width;
    CGFloat h = self.contentView.frame.size.height;
    
    CGRect frame = self.contentView.bounds;
    self.dynamicConcernTableView = [[TJ_DynamicConcernTableView alloc] initWithFrame:frame];
    [self.contentView addSubview:self.dynamicConcernTableView];
    
    frame.origin.x = Screen_Width;
    self.dynamicHotspotTableView = [[TJ_DynamicHotspotTableView alloc] initWithFrame:frame];
    [self.contentView addSubview:self.dynamicHotspotTableView];
    
    frame.origin.x = Screen_Width * 2;
    self.dynamicActivityTableView = [[TJ_DynamicActivityTableView alloc] initWithFrame:frame];
    [self.contentView addSubview:self.dynamicActivityTableView];
    
    //  设置scrollView
    self.contentView.contentSize = CGSizeMake(selectListData.count * w, h);
    self.contentView.pagingEnabled = YES;
}

#pragma mark get data

//获取动态数据
- (void)getDynamicConcernData
{
    __block typeof(self) blockSelf = self;
    [[DynamicNetworkingModel sharedObejct] getDynamicDataWithPage:page success:^(id data) {
        [dynamicConcernListData addObjectsFromArray:data];
        blockSelf.dynamicConcernTableView.dynamicConcernListData = dynamicConcernListData;
        
        [blockSelf.dynamicConcernTableView reloadData];
    } failure:^(id data) {
        NSLog(@"动态关注数据加载失败。。。%@",data);
    }];
}

//获取动态热点数据
- (void)getDynamicHotspotData
{
    __block typeof(self) blockSelf = self;
    [[DynamicNetworkingModel sharedObejct] getHotspotDataWithPage:page success:^(id data) {
        [dynamciHotspotData addObjectsFromArray:data];
        blockSelf.dynamicHotspotTableView.dynamciHotspotData = dynamciHotspotData;
        
        blockSelf.dynamicActivityTableView.dynamciActivityData = dynamciHotspotData;
        [blockSelf.dynamicActivityTableView reloadData];
        
        [blockSelf.dynamicHotspotTableView reloadData];
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

#pragma mark Actions

//点击搜索按钮，弹出搜索视图
- (void)clickRigthButtonAction
{
    [self.navigationController pushViewController:[TJ_DynamicSearchController new] animated:YES];
}

@end
