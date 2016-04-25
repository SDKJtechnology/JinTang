//
//  TJ_GachincoTableView.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/16.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_TarentoTableView.h"
#import "TJ_TarentoTableViewCell.h"
#import "SupportTarentoModel.h"

@implementation TJ_TarentoTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        
        [self registerClass:[TJ_TarentoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TJ_TarentoTableViewCell class])];
    }
    
    return self;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath model:[SupportTarentoModel new] keyPath:@"model" cellClass:[TJ_TarentoTableViewCell class] contentViewWidth:self.width];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *vHeader = [UIView new];
//    vHeader.backgroundColor = [UIColor colorWithWhite:0.856 alpha:1.000];
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    [vHeader addSubview:button];
//    button.frame = CGRectMake(0, 0, 80, 50);
//    [button setTitle:@"24H活跃度" forState:UIControlStateNormal];
//    
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
//    [vHeader addSubview:button1];
//    button1.frame = CGRectMake(0, 0, 80, 50);
//    [button1 setTitle:@"总活跃度" forState:UIControlStateNormal];
//    self.tableHeaderView = vHeader;
//    if (!section)
//        return vHeader;
//    else
//        return nil;
//}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ((TJ_TarentoTableViewCell *)cell).model = [SupportTarentoModel new];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.gachincoData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TJ_TarentoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TJ_TarentoTableViewCell class]) forIndexPath:indexPath];
    cell.identifierImage.hidden = YES;
    if (indexPath.section < 3)
    {
        cell.identifierImage.hidden = NO;
        cell.identifierImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.section + 1]];
    }
    
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
