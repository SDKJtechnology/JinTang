//
//  TJ_EditingDataController.m
//  金堂
//
//  Created by SDKJ on 16/5/26.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_EditingDataController.h"
#import "UIView_extra.h"

@interface TJ_EditingDataController()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *tableViewCellData;
    NSArray *tableViewCellTextLabelData;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TJ_EditingDataController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableViewCellTextLabelData = @[@[@"手机",@"性别",@"签名"],@[@"等级",@"奖学金",@"威望"],@[@"生日"]];
    tableViewCellData = @[@{@"手机":@"231646233",@"性别":@"1",@"签名":@"相爱不一定分开。。。"},@{@"等级":@"新手上路",@"奖学金":@"12",@"威望":@"0"},@{@"生日":@"1991-01－03"}];
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.width, 44)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"编辑资料"];
    
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"xiaoyufu_02"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackButtonAction)];
    navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    [navigationBar pushNavigationItem:navigationItem animated:YES];
    navigationBar.tintColor = [UIColor blackColor];
    
    [self.view addSubview:navigationBar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navigationBar.bottom, self.view.width, self.view.height - navigationBar.bottom) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (cell){
//        NSAttributedString *string = cell.detailTextLabel.attributedText;
//        CGRect frame = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//        return frame.size.height;
//    }
//    else
        return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!section) {
        return 150.f;
    }
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.01;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section < 2) {
        return 3;
    }
    else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = tableViewCellData[indexPath.section];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = tableViewCellTextLabelData[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = dic[cell.textLabel.text];
    
    cell.textLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.097 alpha:1.000];
    
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.font = cell.textLabel.font;
    
    if (indexPath.section == 1) {
        cell.accessoryType = UIAccessibilityTraitNone;
    }
    
    return cell;
}

#pragma mark Actions
/*点击后退按钮*/
- (void)clickBackButtonAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
