//
//  TJ_TableViewModel.m
//  金堂
//
//  Created by SDKJ on 16/5/6.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_TableViewModel.h"

@implementation TJ_TableViewModel

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        
        __block typeof(self) blockSelf = self;
        self.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            blockSelf.myRefreshView = blockSelf.mj_footer;
            [blockSelf loadDataWithView:blockSelf.mj_footer];
        }];
        
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            blockSelf.myRefreshView = blockSelf.mj_header;
            [blockSelf loadDataWithView:blockSelf.mj_header];
        }];
        [self.mj_header beginRefreshing];
        self.mj_footer.hidden = YES;
    }
    
    return self;
}

- (void)loadDataWithView:(MJRefreshComponent *)view
{}

@end
