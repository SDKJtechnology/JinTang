//
//  TJ_DynamicSaerchController.m
//  金堂
//
//  Created by SDKJ on 16/4/21.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_DynamicSearchController.h"

@interface TJ_DynamicSearchController ()<UISearchBarDelegate,
                                        UITableViewDelegate,
                                        UITableViewDataSource>
{
    NSMutableArray *historySearchData;
    
    NSString *saveDataPath;
}

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITableView *contentView;

@end

@implementation TJ_DynamicSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.showsScopeBar = YES;
    self.searchBar.showsCancelButton = NO;
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"请输入搜索内容";
    
    self.navigationItem.titleView = self.searchBar;
    
    self.contentView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.contentView.delegate = self;
    self.contentView.dataSource = self;
    [self.view addSubview:self.contentView];
    self.contentView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.searchBar becomeFirstResponder];
    self.tabBarController.tabBar.hidden = YES;
    [self getHistorySearchData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
    [historySearchData writeToFile:saveDataPath atomically:YES];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    
    BOOL isExist = NO;
    for (NSString *text in historySearchData) {
        if ([text isEqualToString:self.searchBar.text]) {
            isExist = YES;
        }
    }
    if (!isExist)
    {
        if (!historySearchData) {
            historySearchData = [NSMutableArray array];
        }
        [historySearchData insertObject:self.searchBar.text atIndex:0];
        if (historySearchData.count > 10) {
            [historySearchData removeLastObject];
            [self.contentView reloadData];
        }
        else
            [self.contentView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        if (historySearchData.count == 1)
            [self.contentView reloadData];
    }
    
    NSLog(@"开始搜索");
}

- (void)getHistorySearchData
{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    saveDataPath = [documentPath stringByAppendingPathComponent:@"Preferences/historySearchData.plist"];
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:saveDataPath];
    if (!fileExist) {
        [[NSFileManager defaultManager]createFileAtPath:saveDataPath contents:nil attributes:nil];
    }//NSLog(@"%@",saveDataPath);
    historySearchData = [NSMutableArray arrayWithContentsOfFile:saveDataPath];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == historySearchData.count) {
        [historySearchData removeAllObjects];
        [tableView reloadData];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return historySearchData.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row == historySearchData.count) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = [UIColor grayColor];
        if (historySearchData.count) {
            cell.textLabel.text = @"清空搜索记录";
        }
        else
            cell.textLabel.text = @"暂时没有搜索记录";
        CGRect frame = [cell.textLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell.textLabel.font} context:nil];
        CGFloat margin = (self.view.frame.size.width - frame.size.width) / 2;
        cell.separatorInset = UIEdgeInsetsMake(0, margin, 0, margin);
        return cell;
    }

    cell.layer.borderColor = [[UIColor grayColor] CGColor];
    cell.layer.borderWidth = 0.5;
    
    
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.text = historySearchData[indexPath.row];
    
    return cell;
}

// 设定每行能否编辑的状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == historySearchData.count) {
        return NO;
    }
    return YES;
}

// 返回指定cell的操作状态，状态不同左侧出现的操作按钮也不同
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

// Cell编辑的处理(一定要先处理数据，因为操作Cell后，TableView会部分刷新)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 删除
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // 先删除数据
        [historySearchData removeObjectAtIndex:indexPath.row];

        // 再删除对应的Cell
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    if (!historySearchData.count) {
        [tableView reloadData];
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
