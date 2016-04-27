//
//  TJ_DynamicActivityTableView.m
//  金堂
//
//  Created by SDKJ on 16/4/27.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_DynamicActivityTableView.h"
#import "ActivityBigImageCell.h"
#import "ActivityModel.h"

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
    }
    
    return self;
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
    ActivityModel *hots = _dynamciActivityData[indexPath.section];
    ((ActivityBigImageCell *)cell).header = hots.item.header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityModel *model = _dynamciActivityData[indexPath.section];
    Body *body = model.item.header;
    return [tableView cellHeightForIndexPath:indexPath model:body keyPath:@"header"cellClass:[ActivityBigImageCell class] contentViewWidth:self.width];
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
