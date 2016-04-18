//
//  TJ_TopicTableView.m
//  金堂
//
//  Created by SDKJ on 16/4/15.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_TopicTableView.h"
#import "TJ_TopicTableViewCell.h"
#import "TopicModel.h"

@interface TJ_TopicTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TJ_TopicTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        
    }
    
    return self;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicModel *model = [TopicModel new];
    model.ID = indexPath.section + 1;
    ((TJ_TopicTableViewCell *)cell).topicModel = model;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicModel *topicModel = nil;
    CGFloat height = [tableView cellHeightForIndexPath:indexPath model:topicModel keyPath:@"topicModel" cellClass:[TJ_TopicTableViewCell class] contentViewWidth:self.width];
    if (indexPath.section < 3)
        return height;
    else return height - 40 * 0.62;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.topicData.count - 1) {
        return 5;
    }
    return 0.01;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.topicData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class myClass = NSClassFromString([TJ_TopicTableViewCell identifierForModelAtRow:indexPath]);
    NSString *identifer = @"notIdentifierImage";
    if (indexPath.section > 2)
        identifer = @"cell";
    TJ_TopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell)
        cell = [[myClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
    */

@end
