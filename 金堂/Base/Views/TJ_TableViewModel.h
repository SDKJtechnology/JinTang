//
//  TJ_TableViewModel.h
//  金堂
//
//  Created by SDKJ on 16/5/6.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface TJ_TableViewModel : UITableView

@property (nonatomic, strong) MJRefreshComponent *myRefreshView;

@property (nonatomic, strong) UIViewController *myVC;

- (void)loadDataWithView:(MJRefreshComponent *)view;

@end
