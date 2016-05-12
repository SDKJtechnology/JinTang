//
//  TJ_DynamicActivityTableView.m
//  金堂
//
//  Created by SDKJ on 16/4/27.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_DynamicActivityTableView.h"
#import "ActivityBigImageCell.h"
#import "DynamicNetworkingModel.h"

@interface TJ_DynamicActivityTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJ_DynamicActivityTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:UITableViewStyleGrouped]) {
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        [self registerClass:[ActivityBigImageCell class] forCellReuseIdentifier:NSStringFromClass([ActivityBigImageCell class])];
        _dynamciActivityData = [NSMutableArray array];
    }
    
    return self;
}

- (void)loadDataWithView:(MJRefreshComponent *)view
{
    if (view == self.mj_header) {
        [self getDynamciActivityDataWithID:@0];
    }
    if (view == self.mj_footer) {
        
        [self getDynamciActivityDataWithID:@0];
    }
}

- (void)getDynamciActivityDataWithID:(NSNumber *)ID
{
    __block typeof(self) blockSelf = self;
    [[DynamicNetworkingModel sharedObejct] getDynamicActivityDataWithID:ID success:^(id data) {
        if (self.myRefreshView == self.mj_header) {
            _dynamciActivityData = data;
        }
        if (self.myRefreshView == self.mj_footer) {
            [_dynamciActivityData addObjectsFromArray:data];
        }
        [blockSelf reloadData];
        [blockSelf.myRefreshView endRefreshing];
    } failure:^(id data) {
        NSLog(@"动态活动页数据加载错误。。。");
        [self.myRefreshView endRefreshing];
    }];

}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ActivityBigImageCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dynamciActivityData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicActivityModel *hots = _dynamciActivityData[indexPath.section];
    ((ActivityBigImageCell *)cell).activityModel = hots;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicActivityModel *model = _dynamciActivityData[indexPath.section];
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"activityModel"cellClass:[ActivityBigImageCell class] contentViewWidth:self.width];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 5;
}

@end
