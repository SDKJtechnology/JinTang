//
//  TJ_TodayHotTableViewCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/23.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_TodayHotTableViewCell.h"
#import "TJ_HotCollectionViewCell.h"
#import "UIView_extra.h"

@interface TJ_TodayHotTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionViewFlowLayout *flowLayout;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

#define margin 10

@implementation TJ_TodayHotTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.minimumLineSpacing = margin;
        flowLayout.minimumInteritemSpacing = margin;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:flowLayout];
        [self.contentView addSubview:self.collectionView];
        self.collectionView.dataSource = self;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.bounces = NO;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.collectionView registerClass:[TJ_HotCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TJ_HotCollectionViewCell class])];
        self.contentView.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.width, self.height);
    CGFloat w = self.height - 2 * margin;
    flowLayout.itemSize = CGSizeMake(w, w);
}

#pragma mark UICollectionViewDataSorce

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.hotPageData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TJ_HotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TJ_HotCollectionViewCell class]) forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:1.000 green:0.987 blue:0.678 alpha:1.000];
    
    return cell;
}

- (void)setHotPageData:(NSArray *)hotPageData
{
    _hotPageData = hotPageData;
    [self.collectionView reloadData];
}

@end
