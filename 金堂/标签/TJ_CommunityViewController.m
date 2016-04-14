//
//  CommunityViewController.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/13.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_CommunityViewController.h"
#import "TJ_SelectionList.h"

@interface TJ_CommunityViewController ()<TJ_SelectionListDelegate>
{
    NSArray *selectionListData;
}

@property (nonatomic) TJ_SelectionList *selectionList;

@end

@implementation TJ_CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    selectionListData = @[@"最热",@"话题",@"最新"];

    self.selectionList = [[TJ_SelectionList alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
    self.selectionList.seletedTitleColor = [UIColor whiteColor];
    self.selectionList.indicatorColor = [UIColor clearColor];
    self.selectionList.titleColor = [UIColor blackColor];
    self.selectionList.selectItemBackgroundColor = [UIColor greenColor];
    self.selectionList.backgroundColor = [UIColor colorWithRed:0.000 green:0.411 blue:0.000 alpha:1.000];
    [self.selectionList setBorderStyleWithCornerRadius:self.selectionList.height / 2 BorderWidth:0 BorderColor:0];
    self.selectionList.font = [UIFont systemFontOfSize:15];

    [self.selectionList setDidSelectedItemBorderStyleWithCornerRadius:self.selectionList.height / 2 BorderWidth:3 BorderColor:[UIColor colorWithRed:0.000 green:0.411 blue:0.000 alpha:1.000]];

    self.selectionList.delegate = self;
    self.navigationItem.titleView = self.selectionList;
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
//    [self.view addGestureRecognizer:pan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfItemsAtSelectionList:(TJ_SelectionList *)selectionList
{
    return selectionListData.count;
}

- (NSString *)selectionList:(TJ_SelectionList *)selectionList titleForItemWithIndex:(NSInteger)index
{
    return  selectionListData[index];
}

- (void)selectionList:(TJ_SelectionList *)selectionList didSelectItemWithIndex:(NSInteger)index
{
    NSLog(@"sfasfd ");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
