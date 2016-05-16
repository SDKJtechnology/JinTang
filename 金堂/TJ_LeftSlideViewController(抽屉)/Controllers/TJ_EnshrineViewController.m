//
//  TJ_EnshrineViewController.m
//  金堂
//
//  Created by SDKJ on 16/4/26.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_EnshrineViewController.h"
#import "SDAutoLayout.h"
#import "TJ_EnshrineTableViewCell.h"
#import "DataModel+LefiSlide.h"
#import "TJ_TableViewModel.h"

@interface TJ_EnshrineViewController()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *enshrineInvitationData;
}

@property (nonatomic, strong) TJ_TableViewModel *tableView;

@end

@implementation TJ_EnshrineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    enshrineInvitationData = [NSMutableArray array];
    
    self.tableView = [[TJ_TableViewModel alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
//    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak typeof(self) weakSelf = self;
    self.tableView.refreshFinishBlock = ^(MJRefreshComponent *refreshView)
    {
        [weakSelf getEnshrineInvitationDataWithView:refreshView];
    };
    
}
//获取收藏的帖子列表数据
- (void)getEnshrineInvitationDataWithView:(MJRefreshComponent *)refreshView
{
    NSNumber *ID = @0;
    if ([refreshView isKindOfClass:[MJRefreshFooter class]]) {
        DynamicConcernsModel *model = enshrineInvitationData.lastObject;
        ID = model.ID;
    }
    __block typeof (self) blockSelf = self;
    [[DataModel sharedObejct] getEnshrineInvitationDataWithID:ID success:^(id data) {
        if ([ID integerValue] && [data isKindOfClass:[NSArray class]]) {
            [enshrineInvitationData addObjectsFromArray:data];
        }
        else if ([data isKindOfClass:[NSArray class]]){
            enshrineInvitationData = data;
        }
        [blockSelf.tableView reloadData];
        [refreshView endRefreshing];
    } failure:^(id data) {
        NSLog(@"getEnshrineInvitationDataWithView");
        [refreshView endRefreshing];
    }];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicConcernsModel *model = enshrineInvitationData[indexPath.row];
    
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"dynamicConcernsModel" cellClass:[TJ_EnshrineTableViewCell class] contentViewWidth:self.view.width];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor colorWithWhite:0.661 alpha:1.000];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"没有更多内容了";
    
    if (self.enshrineArray.count == section) {
        return label;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ((TJ_EnshrineTableViewCell *)cell).dynamicConcernsModel = enshrineInvitationData[indexPath.row];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return enshrineInvitationData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJ_EnshrineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[TJ_EnshrineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
//    cell.imageView.image = [UIImage imageNamed:@"Bangladeshi"];
//    cell.textLabel.text = @"路上看到减肥了";
//    
    return cell;
}
@end
