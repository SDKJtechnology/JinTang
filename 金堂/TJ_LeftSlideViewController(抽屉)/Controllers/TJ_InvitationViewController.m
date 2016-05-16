//
//  TJ_InvitationViewController.m
//  金堂
//
//  Created by SDKJ on 16/4/26.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_InvitationViewController.h"
#import "SDAutoLayout.h"
#import "TJ_SelectionList.h"
#import "TJ_ReturnInvitaionTableCell.h"
#import "TJ_PostingInvitationTableCell.h"
#import "DataModel+LefiSlide.h"
#import "MJRefresh.h"

@interface TJ_InvitationViewController()<UITableViewDelegate,UITableViewDataSource,TJ_SelectionListDelegate>
{
    NSArray *selectionListTitles;
    
    NSMutableArray *returnInvitationData;
    
    NSMutableArray *postingInvitationData;
    
    MJRefreshBackNormalFooter *footer;
    
    MJRefreshNormalHeader *header;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TJ_SelectionList *selectionList;

@end

NSInteger postingInvitation = 100;
NSInteger returnInvitation = 101;

@implementation TJ_InvitationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    selectionListTitles = @[@"发帖",@"回帖"];
    returnInvitationData = [NSMutableArray array];
    postingInvitationData = [NSMutableArray array];
    
    _selectionList = [[TJ_SelectionList alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 40)];
    _selectionList.delegate = self;
    _selectionList.seletedTitleColor = [UIColor colorWithRed:0.334 green:0.531 blue:1.000 alpha:1.000];
    _selectionList.indicatorColor = _selectionList.seletedTitleColor;
    [self.view addSubview:_selectionList];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, self.view.width, self.view.height - 104)];
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(self.view.width * 2, self.view.height - 104);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    for (NSInteger i = 0; i < selectionListTitles.count; i++) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.width * i, 0, self.view.width, self.scrollView.height) style:UITableViewStylePlain];
        _tableView.tag = postingInvitation + i;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.scrollView addSubview:self.tableView];
//        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
        header.tag = postingInvitation + i;
        _tableView.mj_header = header;
        [_tableView.mj_header beginRefreshing];
        
        footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData:)];
        _tableView.mj_footer = footer;
        footer.tag = postingInvitation + i;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_tableView registerClass:[TJ_ReturnInvitaionTableCell class] forCellReuseIdentifier:NSStringFromClass([TJ_ReturnInvitaionTableCell class])];
        [_tableView registerClass:[TJ_PostingInvitationTableCell class] forCellReuseIdentifier:NSStringFromClass([TJ_PostingInvitationTableCell class])];
    }
}
//开始刷新调用
- (void)loadNewData:(MJRefreshComponent *)refreshVeiw
{
    NSLog(@"-------%ld",refreshVeiw.tag);
    if (refreshVeiw.tag == returnInvitation) {
        if ([refreshVeiw isKindOfClass:[MJRefreshFooter class]] && returnInvitationData.count) {
            DynamicConcernsModel *model = returnInvitationData.lastObject;
            [self getReturnInvitationDataWithID:model.ID RefreshView:refreshVeiw];
        }
        else{
            [self getReturnInvitationDataWithID:@0 RefreshView:refreshVeiw];
        }
    }
    
    if (refreshVeiw.tag == postingInvitation) {
        if ([refreshVeiw isKindOfClass:[MJRefreshFooter class]] && returnInvitationData.count) {
            DynamicConcernsModel *model = returnInvitationData.lastObject;
            [self getPostingInvitationDataWithID:model.ID RefreshView:refreshVeiw];
        }
        else{
            [self getPostingInvitationDataWithID:@0 RefreshView:refreshVeiw];
        }
    }
    
}
//获取发帖数据
- (void)getPostingInvitationDataWithID:(NSNumber *)ID RefreshView:(MJRefreshComponent *)refreshView
{
    [[DataModel sharedObejct] getPostingInvitationDataWithID:ID success:^(id data) {
        
        if (!data && [refreshView isKindOfClass:[MJRefreshFooter class]]) {
            [footer endRefreshingWithNoMoreData];
        }
        
        if ([data isKindOfClass:[NSArray class]]) {
            if ([ID integerValue]) {
                [postingInvitationData addObjectsFromArray:data];
            }
            else{
                postingInvitationData = data;
            }
        }
        
        [self reloadDataWithView:refreshView];
    } failure:^(id data) {
        [refreshView endRefreshing];
        NSLog(@"%@",data);
    }];
}

//获取回帖数据
- (void)getReturnInvitationDataWithID:(NSNumber *)ID RefreshView:(MJRefreshComponent *)refreshView
{
    [[DataModel sharedObejct] getReturnInvitationDataWithID:ID success:^(id data) {
        if ([data isKindOfClass:[NSArray class]] && [ID integerValue]){
            [returnInvitationData addObjectsFromArray:data];
        }
        else if ([data isKindOfClass:[NSArray class]]){
            [footer resetNoMoreData];
            returnInvitationData = data;
        }
        if (!data && [refreshView isKindOfClass:[MJRefreshFooter class]]) {
            [footer endRefreshingWithNoMoreData];
        }
        [self reloadDataWithView:refreshView];
    } failure:^(id data) {
        NSLog(@"获取回帖列表数据失败。。。");
        [refreshView endRefreshing];
    }];

}
//刷新视图
- (void)reloadDataWithView:(MJRefreshComponent *)refreshView
{
    UITableView *tableView = [self.scrollView viewWithTag:refreshView.tag];
    [tableView reloadData];
    [refreshView endRefreshing];
}

#pragma mark TJ_SelectionListDelegate

- (NSInteger)numberOfItemsAtSelectionList:(TJ_SelectionList *)selectionList
{
    return 2;
}

- (NSString *)selectionList:(TJ_SelectionList *)selectionList titleForItemWithIndex:(NSInteger)index
{
    return selectionListTitles[index];
}

- (void)selectionList:(TJ_SelectionList *)selectionList didSelectItemWithIndex:(NSInteger)index
{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = index * frame.size.width;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

#pragma 实现UIScrollViewDelegate 的方法
//  实现scrollView滑动绑定的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UITableView class]])
    {
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.selectionList.selectedItemIndex = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        UITableView *tableView = [scrollView viewWithTag:scrollView.tag];
        [tableView.mj_header endRefreshing];
    }
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == returnInvitation) {
        DynamicConcernsModel *model = returnInvitationData[indexPath.row];
        return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"dynamicConcernsModel" cellClass:[TJ_ReturnInvitaionTableCell class] contentViewWidth: self.view.width];
    }
    if (tableView.tag == postingInvitation) {
        DynamicConcernsModel *model = postingInvitationData[indexPath.row];
        return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"dynamicConcernsModel" cellClass:[TJ_PostingInvitationTableCell class] contentViewWidth: self.view.width];
    }
    return 0;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 30;
//}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UILabel *label = [UILabel new];
//    label.font = [UIFont systemFontOfSize:10];
//    label.textColor = [UIColor colorWithWhite:0.661 alpha:1.000];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = @"没有更多内容了";
//    
//    return label;
//}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == returnInvitation) {
        return returnInvitationData.count;
    }
    if (tableView.tag == postingInvitation) {
        return postingInvitationData.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == returnInvitation) {
        TJ_ReturnInvitaionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TJ_ReturnInvitaionTableCell class]) forIndexPath:indexPath];
        cell.dynamicConcernsModel = returnInvitationData[indexPath.row];
        return cell;
    }
    if (tableView.tag == postingInvitation) {
        TJ_PostingInvitationTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TJ_PostingInvitationTableCell class]) forIndexPath:indexPath];
        cell.dynamicConcernsModel = postingInvitationData[indexPath.row];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"Bangladeshi"];
    cell.textLabel.text = @"路上看到减肥了";

    return cell;
}

@end
