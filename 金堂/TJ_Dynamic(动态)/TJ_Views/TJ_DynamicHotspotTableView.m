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
#import "DataModel+Dynamic.h"
#import "DynamicHotspotModel.h"
#import "TJ_DynamicDetailController.h"

#define sectionHeaderHeight  50

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
        [self registerClass:[TJ_HeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([TJ_HeaderView class])];
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
    [[DataModel sharedObejct] getHotspotDataWithDate:date success:^(id data){
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

#pragma mark - UIScrollViewDelegate
//去掉UItableview headerview黏性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self)
    {
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            
        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
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
    VC.titelString = @"详情";
    [self.myVC presentViewController:VC animated:YES completion:nil];
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
// 自定义headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DynamicHotspotModel *model = _dynamciHotspotData[section][0];
    NSString *createDate = [model.createDate substringWithRange:NSMakeRange(5, model.createDate.length - 5)];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    NSString *currentDeyar = [formatter stringFromDate:[NSDate date]];
    
    if (![currentDeyar isEqualToString:[model.createDate substringWithRange:NSMakeRange(0, 4)]]) {
        createDate = model.createDate;
    }
    
    TJ_HeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([TJ_HeaderView class])];
    view.textLabel.center = view.center;
    view.textLabel.text = createDate;
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 3;
}

@end
