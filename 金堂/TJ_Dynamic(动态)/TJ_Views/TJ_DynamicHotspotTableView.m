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
        self.bounces = NO;
        
        [self registerClass:[AdCell class] forCellReuseIdentifier:NSStringFromClass([AdCell class])];
        [self registerClass:[HotspotCell class] forCellReuseIdentifier:NSStringFromClass([HotspotCell class])];
    }
    
    return self;
}

/*让headerView跟着cell滚动*/
#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 50;
    NSLog(@"%f",scrollView.contentOffset.y);
    //固定section 随着cell滚动而滚动
    if (scrollView.contentOffset.y < 100) {
        
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0)
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AdCell class]) forIndexPath:indexPath];
    else
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HotspotCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotspotModel *model = [HotspotModel new];
    ((HotspotCell *)cell).hotspotModel = model;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotspotModel *model = [HotspotModel new];
    
    if (indexPath.row == 0)
    {
        return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"hotspotModel"cellClass:[AdCell class] contentViewWidth:self.width];
    }
    else return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"hotspotModel"cellClass:[HotspotCell class] contentViewWidth:self.width];

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TJ_HeaderView *view = [[TJ_HeaderView alloc] initWithFrame:CGRectMake(110, 10, 100, 30)];
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
