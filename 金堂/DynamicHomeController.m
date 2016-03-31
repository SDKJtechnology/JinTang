//
//  ViewController.m
//  金堂
//
//  Created by zouxin on 16/3/28.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicHomeController.h"
#import "HTHorizontalSelectionList.h"
#import <UIView+SDAutoLayout.h>

#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height

@interface DynamicHomeController ()<HTHorizontalSelectionListDataSource,HTHorizontalSelectionListDelegate,
UITableViewDelegate,UITableViewDataSource>
{
    NSArray *selectListData;//水平选择列表数据
}

@property (weak, nonatomic) IBOutlet UIScrollView *contentView;
@property (weak, nonatomic) IBOutlet HTHorizontalSelectionList *selectList;//水平选择列表

@end

@implementation DynamicHomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    selectListData = @[@"关注",@"热点",@"活动"];
    
    self.selectList.frame = CGRectMake(0, 64, VIEW_WIDTH, 30);
    
    self.contentView.frame = CGRectMake(0, self.selectList.frame.size.height + 64, VIEW_WIDTH, VIEW_HEIGHT - - self.contentView.frame.origin.y - 49 );
    
        //  添加TableView
        CGFloat w = self.contentView.frame.size.width;
        CGFloat h = self.contentView.frame.size.height;
    for (NSInteger i = 0; i < selectListData.count; i++) {     /* 有多View取决于categories的数量 */
            CGRect frame = self.contentView.bounds;
        frame.origin.x = i * VIEW_WIDTH;
            UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tag = i + 100;
            [self.contentView addSubview:tableView];
        }
        
        //  设置scrollView
    self.contentView.contentSize = CGSizeMake(selectListData.count * w, h);
    self.contentView.pagingEnabled = YES;
    
    [self.selectList setSelectionIndicatorColor:[UIColor blackColor]];
    [self.selectList setTitleFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16] forState:UIControlStateNormal];
    [self.selectList setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.selectList setSelectionIndicatorColor:[UIColor blueColor]];
    self.selectList.delegate = self;
    self.selectList.dataSource = self;
}

#pragma mark HTHorizontalSelectionListDataSource

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList
{
    return selectListData.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index
{
    return selectListData[index];
}

#pragma mark HTHorizontalSelectionListDelegate

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index
{
    //  实现scrollView滑动绑定的方法
    CGRect frame = self.contentView.bounds;
    frame.origin.x = frame.size.width * index;
    [self.contentView scrollRectToVisible:frame animated:YES];
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = @"12";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 10;
}

@end
