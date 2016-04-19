//
//  TJ_GachincoTableView.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/16.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_GachincoTableView.h"
#import "TJ_GachincoTableViewCell.h"

@implementation TJ_GachincoTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
    }
    
    return self;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GachincoModel *model = [[GachincoModel alloc] init:indexPath.row];
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"gachincoModel" cellClass:[TJ_GachincoTableViewCell class] contentViewWidth:self.width];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    GachincoModel *model = [[GachincoModel alloc] init:indexPath.row];
    ((TJ_GachincoTableViewCell *)cell).gachincoModel = model;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.gachincoData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [TJ_GachincoTableViewCell identifierForModelAtRow:[[GachincoModel alloc] init:indexPath.row ]];
    TJ_GachincoTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TJ_GachincoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
