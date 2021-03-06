//
//  TJ_CircleViewController.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/13.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_CircleHomeViewController.h"
#import "TJ_SelectionList.h"
#import "TJ_RecommendTableView.h"
#import "TJ_TopicTableView.h"
#import "TJ_TarentoTableView.h"
#import "TJ_NewTopicViewController.h"

#define statusBarFrame [[UIApplication sharedApplication] statusBarFrame]//状态栏frame
#define navigationBarFrame self.navigationController.navigationBar.frame//navigationbar frame

@interface TJ_CircleHomeViewController ()<TJ_SelectionListDelegate,
                                            UIScrollViewDelegate,TJ_TopicTableViewDelegate>
{
    NSArray *selectionListData;//水平选择列表数据

    NSArray *hotPageData;//热门页数据
    
    NSArray *topicPageData;//话题页面数据
    
    NSArray *gachincoPageData;//最新页面数据
    
    UIView *indicatorView;//
    
    TJ_SelectionList *activeSelectionList;
}

@property (nonatomic) TJ_SelectionList *selectionList;
@property (nonatomic) TJ_RecommendTableView *recommendTableView;
@property (nonatomic) TJ_TopicTableView *topicTableView;
@property (nonatomic) TJ_TarentoTableView *gachincoTableView;
@property (nonatomic) UIScrollView *scrollView;

@end

@implementation TJ_CircleHomeViewController

- (instancetype)init
{
    if (self = [super init]) {
        NSLog(@"sfsdfss");
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    selectionListData = @[@"话题",@"推荐",@"达人"];
    
    hotPageData = @[@"",@"",@"",@"",@"",@"",@"",@"",@""];
    
    topicPageData = hotPageData;
    gachincoPageData = hotPageData;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"tuoyuan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:nil];

    [self setup];
}

- (void)setup
{
    self.selectionList = [[TJ_SelectionList alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
    self.selectionList.delegate = self;
    self.selectionList.seletedTitleColor = [UIColor whiteColor];
    self.selectionList.indicatorColor = [UIColor clearColor];
    self.selectionList.titleColor = [UIColor blackColor];
    self.selectionList.selectItemBackgroundColor = [UIColor colorWithRed:0.275 green:0.476 blue:0.921 alpha:1.000];
    self.selectionList.backgroundColor = [UIColor colorWithRed:0.221 green:0.621 blue:1.000 alpha:1.000];
    [self.selectionList setBorderStyleWithCornerRadius:self.selectionList.height / 2 BorderWidth:0 BorderColor:0];
    self.selectionList.font = [UIFont systemFontOfSize:15];
    //    [self.selectionList setSelectItemBorderStyleWithCornerRadius:6 BorderWidth:5 BorderColor:[UIColor redColor]];
    [self.selectionList setDidSelectedItemBorderStyleWithCornerRadius:self.selectionList.height / 2 BorderWidth:3 BorderColor:self.selectionList.backgroundColor];
//    self.selectionList.selectedItemIndex = 1;
    self.navigationItem.titleView = self.selectionList;
    
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:({
        CGFloat x = 0;
        CGFloat y = statusBarFrame.size.height + navigationBarFrame.size.height;
        CGRect frame = CGRectMake(x, y, self.view.width, self.view.height - self.tabBarController.tabBar.height - y);
        frame;
    })];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
//    self.scrollView.backgroundColor = [UIColor greenColor];
    self.scrollView.contentSize = CGSizeMake(self.view.width * selectionListData.count, self.scrollView.height);
    
    self.topicTableView = [[TJ_TopicTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.scrollView.height)];
    [self.scrollView addSubview:self.topicTableView];
    self.topicTableView.delegateTopic = self;
    self.topicTableView.topicData = topicPageData;
    
    self.recommendTableView = [[TJ_RecommendTableView alloc] initWithFrame:CGRectMake(self.view.width, 0, self.view.width, self.scrollView.height)];
    [self.scrollView addSubview:self.recommendTableView];
    
    activeSelectionList = [[TJ_SelectionList alloc] initWithFrame:CGRectMake(self.view.width * 2, 0, self.view.width, 30)];
    activeSelectionList.tag = 101;
    activeSelectionList.delegate = self;
    activeSelectionList.seletedTitleColor = [UIColor blackColor];
    activeSelectionList.indicatorColor = [UIColor colorWithRed:0.262 green:0.446 blue:1.000 alpha:1.000];
    activeSelectionList.titleColor = [UIColor grayColor];
    activeSelectionList.backgroundColor = [UIColor colorWithWhite:0.820 alpha:1.000];
    activeSelectionList.selectItemBackgroundColor = activeSelectionList.backgroundColor;
    activeSelectionList.font = [UIFont systemFontOfSize:15];
    [self.scrollView addSubview:activeSelectionList];
    
    self.gachincoTableView = [[TJ_TarentoTableView alloc] initWithFrame:CGRectMake(self.view.width * 2, 30, self.view.width, self.scrollView.height) style:UITableViewStylePlain];
    [self.scrollView addSubview:self.gachincoTableView];
    self.gachincoTableView.gachincoData = gachincoPageData;
}

#pragma mark TJ_SelectionListDelegate

- (NSInteger)numberOfItemsAtSelectionList:(TJ_SelectionList *)selectionList
{
    if (selectionList.tag == 101) {
        return 2;
    }
    return selectionListData.count;
}

- (NSString *)selectionList:(TJ_SelectionList *)selectionList titleForItemWithIndex:(NSInteger)index
{
    if (selectionList.tag == 101) {
        NSArray *array = @[@"24H活跃度",@"总活跃度"];
        return array[index];
    }
    return  selectionListData[index];
}

- (void)selectionList:(TJ_SelectionList *)selectionList didSelectItemWithIndex:(NSInteger)index
{
    if (selectionList.tag == 101) {
        return ;
    }
    else
    {
        //  实现scrollView滑动绑定的方法
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = frame.size.width * index;
        [self.scrollView scrollRectToVisible:frame animated:YES];
    }
}

#pragma 实现UIScrollViewDelegate 的方法
//  实现scrollView滑动绑定的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UITableView class]])
    {
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.selectionList.selectedItemIndex = page;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (scrollView.contentOffset.x == targetContentOffset->x && scrollView.contentOffset.y == targetContentOffset->y  && ![scrollView isKindOfClass:[UITableView class]] && targetContentOffset->x == 0) {
        [self openOrCloseLeftList];
    }
}

#pragma mark TJ_TopicTableViewDelegate

- (void)didClickNavigationButtonAtTitel:(NSString *)title
{
    if ([title isEqualToString:@"最新话题"]) {
        TJ_NewTopicViewController *viewController = [TJ_NewTopicViewController new];
        viewController.titelString = title;
        
        [self presentViewController:viewController animated:YES completion:nil];
    }
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
