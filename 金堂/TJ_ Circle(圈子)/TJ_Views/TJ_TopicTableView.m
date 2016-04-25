//
//  TJ_TopicTableView.m
//  金堂
//
//  Created by SDKJ on 16/4/15.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_TopicTableView.h"
#import "TJ_TopicTableViewCell.h"
#import "TJ_TopicNavigationTableViewCell.h"
#import "TopicModel.h"

@interface TJ_TopicTableView()<UITableViewDelegate,UITableViewDataSource,TJ_TopicNavigationTableViewCellDelegate>

@end

@implementation TJ_TopicTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[TJ_TopicTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TJ_TopicTableViewCell class])];
        [self registerClass:[TJ_TopicNavigationTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TJ_TopicNavigationTableViewCell class])];
    }
    
    return self;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section)
        ((TJ_TopicTableViewCell *)cell).topicModel = [TopicModel new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!section) {
        return 0.01;
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
    titleLabel.text = @"本周话题排行";
    
    if (section)
        return vHeader;
    else
        return nil;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!section) {
        return 1;
    }
    return self.topicData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (!indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TJ_TopicNavigationTableViewCell class]) forIndexPath:indexPath];
        ((TJ_TopicNavigationTableViewCell *)cell).delegate = self;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TJ_TopicTableViewCell class]) forIndexPath:indexPath];
        ((TJ_TopicTableViewCell *)cell).identifierImage.hidden = YES;
        if (indexPath.row < 3)
        {
            ((TJ_TopicTableViewCell *)cell).identifierImage.hidden = NO;
            ((TJ_TopicTableViewCell *)cell).identifierImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row + 1]];
        }
    }
    
    return cell;
}

- (void)didClickTopicNavigationButton:(TJ_TopicNavigationTableViewCell *)cell Titel:(NSString *)title
{
    [self.delegateTopic didClickNavigationButtonAtTitel:title];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
    */

@end
