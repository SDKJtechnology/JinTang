//
//  LX_chatoneTableViewController.m
//  金堂
//
//  Created by zouxin on 16/5/4.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "LX_chatoneTableViewController.h"
#import <Masonry.h>
#import "LX_reportViewController.h"
#import "LX_homePageViewController.h"

@interface LX_chatoneTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@end

@implementation LX_chatoneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"聊天详情";
    
    }

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = @"Hello TableView";
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section ==0) {
        cell.textLabel.text = @"Ta的主页";
        UIImage *image = [UIImage imageNamed:@"kongjian.png"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.image = image;
        [cell.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            make.right.mas_equalTo(20);
        }];
    }else if (indexPath.section ==1){
        cell.textLabel.text = @"举报";
        //点击tableviewcell跳转到举报页面
        
     
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.height/12;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        
        LX_reportViewController *reportViewcontroller = [LX_reportViewController new];
      
        //由导航栏推出
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:reportViewcontroller];
        [self presentViewController:navi animated:YES completion:nil];
        
    }else if (indexPath.section ==0){
        LX_homePageViewController *homePageViewControler = [LX_homePageViewController new];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:homePageViewControler];
       
        [self presentViewController:navi animated:YES completion:nil];
        
    }
   
    
  
    
}
@end
