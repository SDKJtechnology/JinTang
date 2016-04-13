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
    CGFloat cornerRadius_;
    
    CGFloat borderWidth_;
    
    UIColor *borderColor_;
    
    CGFloat selectedCornerRadius_;
    
    CGFloat selectedBorderWidth_;
    
    UIColor *selectedBorderColor_;

    NSInteger items;
    
    CGFloat itemWidth;
    
    BOOL isSeleted;
}

@property (nonatomic, strong) UICollectionView *collectionView;
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
        self.titleColor = [UIColor blackColor];
        self.seletedTitleColor = [UIColor grayColor];
        self.indicatorColor = [UIColor grayColor];
        self.selectItemBackgroundColor = [UIColor whiteColor];
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
    cell.titleColor = self.titleColor;
    [cell setBorderStyleWithCornerRadius:cornerRadius_ BorderWidth:borderWidth_ BorderColor:borderColor_];
    cell.font = self.font;
//    cell.backgroundColor = self.selectItemBackgroundColor;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectedItem = indexPath.row;
    isSeleted = YES;
    self.selectedItemIndex = indexPath.row;
    if ([self.delegate respondsToSelector:@selector(selectionList:titleForItemWithIndex:)])
        [self.delegate selectionList:self didSelectItemWithIndex:indexPath.row];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    ((TJ_SelectionListCell *)cell).seletedTitleColor = self.titleColor;
    ((TJ_SelectionListCell *)cell).indicatorColor = [UIColor clearColor];
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(numberOfItemsAtSelectionList:)])
    {
            items = [self.delegate numberOfItemsAtSelectionList:self];
            itemWidth = self.width / items;
            if (self.selectionItemMode == TJSelectionItemModeEqualWidth) {
               return CGSizeMake(itemWidth, self.height);
            }
    }
    return CGSizeMake(itemWidth, self.height);
}

- (void)setSelectedItemIndex:(NSInteger)selectedItemIndex
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:selectedItemIndex inSection:0];
    if((oldSelectedIndex.row != selectedItemIndex && !isSeleted) || selectedItemIndex == selectedItem)
    {
        isSeleted = NO;
        [self reloadItemState:indexPath];
    }
}

- (void)reloadItemState:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    ((TJ_SelectionListCell *)cell).seletedTitleColor = self.seletedTitleColor;
    ((TJ_SelectionListCell *)cell).indicatorColor = self.indicatorColor;
    [((TJ_SelectionListCell *)cell) setDidSelectedItemBorderStyleWithCornerRadius:selectedCornerRadius_ BorderWidth:selectedBorderWidth_ BorderColor:selectedBorderColor_];
    ((TJ_SelectionListCell *)cell).backgroundColor = self.selectItemBackgroundColor;
    if (oldSelectedIndex != indexPath) {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:oldSelectedIndex];
        ((TJ_SelectionListCell *)cell).seletedTitleColor = self.titleColor;
        ((TJ_SelectionListCell *)cell).indicatorColor = [UIColor clearColor];
        [((TJ_SelectionListCell *)cell) setDidSelectedItemBorderStyleWithCornerRadius:0 BorderWidth:0 BorderColor:0];
        ((TJ_SelectionListCell *)cell).backgroundColor = [UIColor clearColor];
    }

    selectedItem = NSIntegerMax;
    oldSelectedIndex = indexPath;
}
//设置self的边框样式
- (void)setBorderStyleWithCornerRadius:(CGFloat)cornerRadius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)borderColor
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
}
//设置所有选项的边框样式
- (void)setSelectItemBorderStyleWithCornerRadius:(CGFloat)cornerRadius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)borderColor
{
        cornerRadius_ = cornerRadius;
        borderColor_ = borderColor;
        borderWidth_ = borderWidth;
}
//设置已经选中的选项边框样式
- (void)setDidSelectedItemBorderStyleWithCornerRadius:(CGFloat)cornerRadius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)borderColor
{
    selectedBorderColor_ = borderColor;
    selectedBorderWidth_ = borderWidth;
    selectedCornerRadius_ = cornerRadius;
}
//设置背景颜色
- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _collectionView.backgroundColor = backgroundColor;
}

@end
