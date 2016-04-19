//
//  TJ_ClassificationListTableView.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/17.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_ClassificationListTableView.h"
#import "TJ_ClassificationListCell.h"

@interface TJ_ClassificationListTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJ_ClassificationListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
    }
    
    return self;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConcernModel *model = [ConcernModel new];
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"concernModel" cellClass:[TJ_ClassificationListCell class] contentViewWidth:self.width];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJ_ClassificationListCell *cell1 = (TJ_ClassificationListCell*)cell;
    cell1.concernModel = [ConcernModel new];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJ_ClassificationListCell *cell = [[TJ_ClassificationListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
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
