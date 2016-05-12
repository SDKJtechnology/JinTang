//
//  TJ_DynamicHotspotTableView.m
//  金堂
//
//  Created by SDKJ on 16/4/27.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_DynamicHotspotTableView.h"
#import "AdCell.h"
#import "HotspotCell.h"
#import "TJ_HeaderView.h"
#import "DynamicNetworkingModel.h"
#import "DynamicHotspotModel.h"
#import "TJ_DynamicDetailController.h"

@interface TJ_DynamicHotspotTableView()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TJ_DynamicHotspotTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:UITableViewStylePlain]) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
//        self.bounces = NO;
        
        [self registerClass:[AdCell class] forCellReuseIdentifier:NSStringFromClass([AdCell class])];
        [self registerClass:[HotspotCell class] forCellReuseIdentifier:NSStringFromClass([HotspotCell class])];
        _dynamciHotspotData = [NSMutableArray array];
    }
    
    return self;
}

- (void)loadDataWithView:(MJRefreshComponent *)view
{
    if (self.mj_header == view) {
        [self getDynamciHotspotDataWithDate:@""];
    }
    if (self.mj_footer == view) {
        DynamicHotspotModel *model = _dynamciHotspotData.lastObject[0];
        if (!model) {
            [self.myRefreshView endRefreshing];
            return;
        }
        [self getDynamciHotspotDataWithDate:model.createDate];
    }
}

- (void)getDynamciHotspotDataWithDate:(NSString *)date
{
    __block typeof(self) blockSelf = self;
    [[DynamicNetworkingModel sharedObejct] getHotspotDataWithDate:date success:^(id data){
        if (blockSelf.myRefreshView == blockSelf.mj_footer) {
            [_dynamciHotspotData addObjectsFromArray:data];
        }
        if (blockSelf.myRefreshView == blockSelf.mj_header) {
            _dynamciHotspotData = data;
        }
        [blockSelf reloadData];
        [blockSelf.myRefreshView endRefreshing];
    } failure:^(id data) {
        NSLog(@"关注活动页加载数据失败。。。");
        [blockSelf.myRefreshView endRefreshing];
    }];
}

/*让headerView跟着cell滚动*/
#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 50;
//    NSLog(@"%f",scrollView.contentOffset.y);
    
    //固定section 随着cell滚动而滚动
    if (scrollView.contentOffset.y < 100 && !self.myRefreshView.isRefreshing) {
        
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        UIEdgeInsets edgeInsets = scrollView.contentInset;
        edgeInsets.top = -sectionHeaderHeight;
        scrollView.contentInset = edgeInsets;
    }
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AdCell class]) forIndexPath:indexPath];
    }
    else
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HotspotCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dynamciHotspotData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = _dynamciHotspotData[section];
    return array.count;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJ_DynamicDetailController *VC = [[TJ_DynamicDetailController alloc] init];
    VC.showBottomView = NO;
    [_myVC presentViewController:VC animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ((HotspotCell *)cell).hotspotModel = _dynamciHotspotData[indexPath.section][indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicHotspotModel *model = _dynamciHotspotData[indexPath.section][indexPath.row];
    
    if (indexPath.row == 0)
    {
        return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"hotspotModel"cellClass:[AdCell class] contentViewWidth:self.width];
    }
    else return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"hotspotModel"cellClass:[HotspotCell class] contentViewWidth:self.width];

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TJ_HeaderView *view = [[TJ_HeaderView alloc] initWithFrame:CGRectMake(110, 10, 100, 30)];
    DynamicHotspotModel *model = _dynamciHotspotData[section][0];
    NSString *string = [model.createDate substringWithRange:NSMakeRange(3, model.createDate.length - 3)];
    view.dateLabel.text = string;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 3;
}

@end
