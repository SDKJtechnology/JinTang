//
//  TJSelectionList.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/6.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_SelectionList.h"
#import "SDAutoLayout.h"
#import "TJ_SelectionListCell.h"

static  NSIndexPath *oldSelectedIndex;
static NSInteger selectedItem;

@interface TJ_SelectionList()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger items;
    CGFloat itemWidth;
    
    BOOL isSeleted;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIView *indicatorView;

@end

static NSString *identifier = @"cell";

@implementation TJ_SelectionList

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self commonInit];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [self.collectionView registerClass:[TJ_SelectionListCell class] forCellWithReuseIdentifier:identifier];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self reloadItemState:indexPath];
    
    [super layoutSubviews];
}

- (void)commonInit
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 列与列(水平卷动)/行与行(垂直卷动)之间的最小距离
    flowLayout.minimumLineSpacing = 0;
    // 两个连续的cell之间的最小距离
    flowLayout.minimumInteritemSpacing = 0;
    // 每一个cell的大小
//    flowLayout.itemSize = CGSizeMake(138, 40);
    // 卷动的方向(默认是垂直)
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 每一个cell的margin
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.scrollsToTop = NO;
    _collectionView.canCancelContentTouches = YES;
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(numberOfItemsAtSelectionList:)])
    return [self.delegate numberOfItemsAtSelectionList:self];
    else return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TJ_SelectionListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.titleSting = [self.delegate selectionList:self titleForItemWithIndex:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectedItem = indexPath.row;
    isSeleted = YES;
    if ([self.delegate respondsToSelector:@selector(selectionList:titleForItemWithIndex:)])
        [self.delegate selectionList:self didSelectItemWithIndex:indexPath.row];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    ((TJ_SelectionListCell *)cell).seletedTitleColor = [UIColor grayColor];
    ((TJ_SelectionListCell *)cell).indicatorColor = [UIColor clearColor];
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(numberOfItemsAtSelectionList:)])
    {
            items = [self.delegate numberOfItemsAtSelectionList:self];
            itemWidth = self.width / items;
            if (self.selectionItemStyle == TJSelectionItemModeEqualWidth) {
               return CGSizeMake(itemWidth, self.height);
            }
    }
    return CGSizeMake(itemWidth, self.height);
}

- (void)setSelectedItemIndex:(NSInteger)selectedItemIndex
{
    if ((oldSelectedIndex.row != selectedItemIndex && !isSeleted) || selectedItemIndex == selectedItem)
    {
        isSeleted = NO;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:selectedItemIndex inSection:0];
        [self reloadItemState:indexPath];
    }
}

- (void)reloadItemState:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    ((TJ_SelectionListCell *)cell).seletedTitleColor = [UIColor blackColor];
    ((TJ_SelectionListCell *)cell).indicatorColor = [UIColor blueColor];
    if (oldSelectedIndex != indexPath) {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:oldSelectedIndex];
        ((TJ_SelectionListCell *)cell).seletedTitleColor = [UIColor grayColor];
        ((TJ_SelectionListCell *)cell).indicatorColor = [UIColor clearColor];
    }

    selectedItem = NSIntegerMax;
    oldSelectedIndex = indexPath;
}

@end
