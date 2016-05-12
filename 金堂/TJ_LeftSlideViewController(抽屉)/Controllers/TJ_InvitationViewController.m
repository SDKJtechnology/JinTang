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
#import "DynamicConcernNotImageCell.h"
#import "MJRefresh.h"

@interface TJ_InvitationViewController()<UITableViewDelegate,UITableViewDataSource,TJ_SelectionListDelegate>
{
    NSArray *selectionListTitles;
    
    NSMutableArray *returnInvitationData;
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
        _scrollView.tag = postingInvitation + i;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.scrollView addSubview:self.tableView];
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            NSLog(@"%ld",_tableView.tag);
        }];
        [_tableView.mj_header beginRefreshing];
    }
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [_tableView registerClass:[DynamicConcernNotImageCell class] forCellReuseIdentifier:NSStringFromClass([DynamicConcernNotImageCell class])];
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

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == returnInvitation) {
        DynamicConcernsModel *model = returnInvitationData[indexPath.row];
        return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"dynamicConcernsModel" cellClass:DynamicConcernNotImageCell.class contentViewWidth: self.view.width];
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor colorWithWhite:0.661 alpha:1.000];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"没有更多内容了";
    
    return label;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == returnInvitation) {
        return returnInvitationData.count;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == returnInvitation) {
        DynamicConcernNotImageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DynamicConcernNotImageCell class])];
        cell.dynamicConcernsModel = returnInvitationData[indexPath.row];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.imageView.image = [UIImage imageNamed:@"Bangladeshi"];
    cell.textLabel.text = @"路上看到减肥了";

    return cell;
}

@end
