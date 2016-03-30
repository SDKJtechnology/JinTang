//
//  ViewController.m
//  金堂
//
//  Created by zouxin on 16/3/28.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DynamicHomeController.h"
#import "HTHorizontalSelectionList.h"

@interface DynamicHomeController ()<HTHorizontalSelectionListDataSource,HTHorizontalSelectionListDelegate>
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
    
    [self.selectList setSelectionIndicatorColor:[UIColor blackColor]];
    [self.selectList setTitleFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16] forState:UIControlStateNormal];
    [self.selectList setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.selectList setSelectionIndicatorColor:[UIColor blueColor]];
    self.selectList.delegate = self;
    self.selectList.dataSource = self;
}

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList
{
    return selectListData.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index
{
    return selectListData[index];
}

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index
{
    
}

@end
