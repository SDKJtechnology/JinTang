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
#import "DynamicNotImageCell.h"
#import "DynamicModel.h"
#import "DynamicDataModel.h"

#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height

@interface DynamicHomeController ()<HTHorizontalSelectionListDataSource,HTHorizontalSelectionListDelegate,
    UITableViewDelegate,UITableViewDataSource
    ,UIScrollViewDelegate>
{
    NSArray *selectListData;//水平选择列表数据
    
    NSMutableArray *dynamicListData;
}

@property (strong, nonatomic) IBOutlet UIScrollView *contentView;
@property (strong, nonatomic) IBOutlet HTHorizontalSelectionList *selectList;//水平选择列表

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
    [DynamicDataModel getDynamicDataWithPage:page];
    
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
    ModelTableViewCell *cell = nil;
    NSString *identifier = [DynamicNotImageCell identifierForModelAtRow:nil];
    Class cellClass = NSClassFromString(identifier);
    if (!cell){
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 100:
        {
            DynamicModel *dynamicModel = [DynamicModel new];
            dynamicModel.titleString = @"sjdjkfjkj深刻的话费卡收到回复开机萨哈夫跨时代妇科哈萨克奋斗哈舒服咖还是当付款哈时代";
            dynamicModel.nameString = @"小李";
            dynamicModel.countString = @"21阅读";
            dynamicModel.timeString = @"2514241";
            ((DynamicNotImageCell *)cell).dynamicModel = dynamicModel;
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
