//
//  TJ_ClassificationTableView.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/17.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_CommunityclassificationTableView.h"
#import "SDAutoLayout.h"
#import "DataModel+Community.h"

@interface TJ_CommunityclassificationTableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *classificationData;

@end

@implementation TJ_CommunityclassificationTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.classificationData = @[@"全金堂",@"幸福门",@"娱乐圈",@"发广告",@"吃喝玩",@"我的关注"];
        [self getCommunityData];
    }
    
    return self;
}

- (void)getCommunityData
{
    [[DataModel sharedObejct] getCommunityDataSuccess:^(id data) {
        
        
    } failure:^(id data) {
        
    }];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.width / 2;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJ_CommunityclassificationTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = self.selectTextLabelTextColor;
    cell.indicatorView.backgroundColor = self.selectTextLabelTextColor;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJ_CommunityclassificationTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = self.textLabelTextColor;
    cell.indicatorView.backgroundColor = cell.backgroundColor;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classificationData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static UIImageView *selectView = nil;
    TJ_CommunityclassificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
         cell = [[TJ_CommunityclassificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        selectView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beijing1"]];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithWhite:0.882 alpha:1.000];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textLabel.textColor = self.textLabelTextColor;
    cell.textLabel.text = self.classificationData[indexPath.row];
    cell.imageView.backgroundColor = [UIColor redColor];
    cell.selectedBackgroundView = selectView;
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

@implementation TJ_CommunityclassificationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.indicatorView = [UIView new];
        [self.contentView addSubview:self.indicatorView];
        
        self.indicatorView.sd_layout
        .topSpaceToView(self.contentView, 0)
        .leftSpaceToView(self.contentView, 0)
        .widthIs(3)
        .bottomSpaceToView(self.contentView, 0);
        self.indicatorView.backgroundColor = self.backgroundColor;
    }
    
    return self;
}

@end
