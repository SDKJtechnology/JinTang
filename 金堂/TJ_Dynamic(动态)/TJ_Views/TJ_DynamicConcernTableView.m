//
//  TJ_DynamicConcernTableView.m
//  金堂
//
//  Created by SDKJ on 16/4/27.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_DynamicConcernTableView.h"
#import "DynamicConcernNotImageCell.h"

@interface TJ_DynamicConcernTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJ_DynamicConcernTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:UITableViewStylePlain]) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
    }
    
    return self;
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
    return cell;
}

- (void)setDynamicConcernListData:(NSArray *)dynamicConcernListData
{
    _dynamicConcernListData = dynamicConcernListData;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dynamicConcernListData.count;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    DynamicList *model = _dynamicConcernListData[indexPath.row];
    ((DynamicConcernNotImageCell *)cell).dynamicList = model;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    // cell自适应设置
    DynamicList * model = _dynamicConcernListData[indexPath.row];
    // 返回计算出的cell高度（普通简化版方法，同样只需一步设置即可完成）
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"dynamicList" cellClass:[DynamicConcernNotImageCell class] contentViewWidth:self.width];
}

@end
