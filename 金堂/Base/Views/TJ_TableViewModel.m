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
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            blockSelf.myRefreshView = blockSelf.mj_footer;
            [blockSelf loadDataWithView:blockSelf.mj_footer];
            blockSelf.refreshFinishBlock(blockSelf.mj_footer);
        }];
        self.mj_footer = footer;
        
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            blockSelf.myRefreshView = blockSelf.mj_header;
            [blockSelf loadDataWithView:blockSelf.mj_header];
            if (blockSelf.refreshFinishBlock) {
                blockSelf.refreshFinishBlock(blockSelf.mj_header);
            }
        }];
        [self.mj_header beginRefreshing];
    }
    
    return self;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.myRefreshView.isRefreshing) {
        [self.myRefreshView endRefreshing];
    }
}

- (void)loadDataWithView:(MJRefreshComponent *)view
{}

@end
