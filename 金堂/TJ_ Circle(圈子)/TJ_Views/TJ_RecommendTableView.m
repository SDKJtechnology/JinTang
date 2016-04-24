//
//  TJ_ RecommendTableView.m
//  金堂
//
//  Created by SDKJ on 16/4/22.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_RecommendTableView.h"
#import "TJ_TopicTableViewCell.h"
#import "TJ_TodayHotTableViewCell.h"

@interface TJ_RecommendTableView()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *sectionTitleArray;
    
    NSArray *accessoriesTitleArray;
}

@end

@implementation TJ_RecommendTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        
        [self registerClass:[TJ_TopicTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TJ_TopicTableViewCell class])];
        [self registerClass:[TJ_TodayHotTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TJ_TodayHotTableViewCell class])];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        
        sectionTitleArray = @[@"推荐话题",@"今日热门",@"新帖广场"];
        accessoriesTitleArray = @[@"更多话题》",@"       更多》",@"附近动态》"];
    }
    
    return self;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.section)
        ((TJ_TopicTableViewCell *)cell).topicModel = [TopicModel new];
    else if (indexPath.section == 1)
        ((TJ_TodayHotTableViewCell *)cell).hotPageData = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.section)
        return 50;
    else if (indexPath.section == 1)
        return 100;
    else
        return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section > 2) {
        return 10;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vHeader = [UIView new];
    vHeader.backgroundColor = [UIColor colorWithWhite:0.856 alpha:1.000];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
    [vHeader addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor colorWithWhite:0.591 alpha:1.000];
    titleLabel.text = sectionTitleArray[section];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [vHeader addSubview:button];
    button.frame = CGRectMake(tableView.frame.size.width - 80, 0, 80, 30);
    [button setTitle:accessoriesTitleArray[section] forState:UIControlStateNormal];
    button.titleLabel.font = titleLabel.font;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [button setTitleColor:titleLabel.textColor forState:UIControlStateNormal];
    
    if (section < 3)
        return vHeader;
    else
        return nil;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!section)  return 4;
    if (section == 1)  return 1;
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (!indexPath.section)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TJ_TopicTableViewCell class]) forIndexPath:indexPath];
    }
    else if (indexPath.section == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TJ_TodayHotTableViewCell class]) forIndexPath:indexPath];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    }
    return cell;
}

@end
