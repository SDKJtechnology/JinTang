//
//  TJ_SetingViewController.m
//  金堂
//
//  Created by SDKJ on 16/4/18.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_SetingViewController.h"

typedef NS_ENUM(NSInteger, TJ_SwitchTagValue)
{
    TJ_SwitchTagValuePush,
    TJ_SwitchTagValueNotImage
};

@interface TJ_SetingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *cellTitle;//cell textLabel字符串
    
    NSString *cacheSize;//缓存大小
    
    BOOL isPush;//是否推送
    
    BOOL isNotImage;//是否无图
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TJ_SetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设置";

    isPush = YES;
    isNotImage = NO;
    cacheSize = @"5.89MB";
    cellTitle = @[@[@"推送消息",@"浏览记录",@"社区无图模式",@"清除缓存"],@[@"意见反馈",@"版本更新",@"关于我们"],@[@"退出当前账号"]];
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 64;
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section + 1) * 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return cellTitle.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = cellTitle[section];
    switch (section) {
        case 0:
            return array.count;
            break;
        case 1:
            return array.count;
            break;
        default:
            return array.count;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    NSArray *array = cellTitle[indexPath.section];
    cell.textLabel.text = array[indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!indexPath.section) {
        if (!indexPath.row || indexPath.row == 2) {
            UISwitch *switchView = [UISwitch new];
            switchView.on = !indexPath.row ? isPush : isNotImage;
            switchView.tag = !indexPath.row ? TJ_SwitchTagValuePush : TJ_SwitchTagValueNotImage;
            [switchView addTarget:self action:@selector(switchViewAction:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = switchView;
        }
        else if (indexPath.row == 3)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.detailTextLabel.text = cacheSize;
        }
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPath.section == 2) {
        CGRect frame = [cell.textLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell.textLabel.font} context:nil];
        CGFloat margin = (self.view.frame.size.width - frame.size.width) / 2;
        cell.separatorInset = UIEdgeInsetsMake(0, margin, 0, margin);
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)switchViewAction:(UISwitch *)sender
{
    if (sender.isOn) {
        NSLog(@"开 tag = %ld",sender.tag);
    }
    else
        NSLog(@"关  tag = %ld",sender.tag);
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
