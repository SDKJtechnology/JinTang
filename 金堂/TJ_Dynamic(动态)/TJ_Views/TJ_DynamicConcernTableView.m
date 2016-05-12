//
//  TJ_DynamicConcernTableView.m
//  金堂
//
//  Created by SDKJ on 16/4/27.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_DynamicConcernTableView.h"
#import "DynamicConcernNotImageCell.h"
#import "DataModel+Dynamic.h"

@interface TJ_DynamicConcernTableView()<UITableViewDelegate,UITableViewDataSource>
{
//    NSMutableArray *dynamicConcernListData;
}

@end

@implementation TJ_DynamicConcernTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:UITableViewStylePlain]) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
//        self.bounces = NO;
        _dynamicConcernListData = [NSMutableArray array];
    }
    
    return self;
}

- (void)loadDataWithView:(MJRefreshComponent *)view
{
    if (view == self.mj_header) {
        [self getDynamicConcernDataWithID:@0];
    }
    if (view == self.mj_footer) {
        DynamicConcernsModel *model = _dynamicConcernListData.lastObject;
        if (!model) {
            [self.myRefreshView endRefreshing];
            return;
        }
        [self getDynamicConcernDataWithID:model.ID];
    }
}

//获取动态数据
- (void)getDynamicConcernDataWithID:(NSNumber *)ID
{
    __block typeof(self) blockSelf = self;
    [[DataModel sharedObejct] getDynamicConcernsDataWithID:ID success:^(id data) {
        //..下拉刷新
        if (blockSelf.myRefreshView == blockSelf.mj_header) {
            _dynamicConcernListData = data;
        }else if(blockSelf.myRefreshView == blockSelf.mj_footer){
            [_dynamicConcernListData addObjectsFromArray:data];
        }
        [blockSelf reloadData];
        [blockSelf.myRefreshView endRefreshing];
    } failure:^(id data) {
        NSLog(@"动态关注数据加载失败。。。%@",data);
        [blockSelf.myRefreshView endRefreshing];
    }];
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSString *identifier = [DynamicConcernNotImageCell identifierForModelAtRow:_dynamicConcernListData[indexPath.row]];
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[DynamicConcernNotImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.sd_tableView = tableView;
    cell.sd_indexPath = indexPath;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dynamicConcernListData.count;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectRowAtIndexPath) {
        self.didSelectRowAtIndexPath(indexPath);
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    DynamicConcernsModel *model = _dynamicConcernListData[indexPath.row];
    ((DynamicConcernNotImageCell *)cell).dynamicConcernsModel = model;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    // cell自适应设置
    DynamicConcernsModel * model = _dynamicConcernListData[indexPath.row];
    // 返回计算出的cell高度（普通简化版方法，同样只需一步设置即可完成）
    return [self cellHeightForIndexPath:indexPath model:model keyPath:@"dynamicConcernsModel" cellClass:[DynamicConcernNotImageCell class] contentViewWidth:self.width];
}

@end
