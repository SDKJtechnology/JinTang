//
//  TJ_HotTableView.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/14.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_HotCollectionView.h"
#import "TJ_HotCollectionViewCell.h"

@interface TJ_HotCollectionView()<UICollectionViewDataSource>

@end

@implementation TJ_HotCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        
        [self registerClass:[TJ_HotCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TJ_HotCollectionViewCell class])];
        [self registerClass:[TJ_HotCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
    }
    
    return self;
}

#pragma mark UICollectionViewDataSorce

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.hotPageData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TJ_HotCollectionViewCell *cell = nil;
    if (indexPath.item % 4 == 0 || (indexPath.item + 1) % 4 == 0)
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TJ_HotCollectionViewCell class]) forIndexPath:indexPath];
    else
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:1.000 green:0.987 blue:0.678 alpha:1.000];
    cell.tag = 100 + indexPath.item;
    
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
