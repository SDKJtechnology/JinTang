//
//  TJ_ImagePickerView.m
//  金堂
//
//  Created by SDKJ on 16/5/9.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_ImagePickerView.h"
#import "AlbumNavigationController.h"
#import "TJ_ShowPhotoCollectionCell.h"

@interface TJ_ImagePickerView()<AlbumNavigationControllerDelegate, UICollectionViewDataSource,UICollectionViewDelegate,TJ_ShowPhotoCollectionCellDelegate> {
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    
    CGFloat _itemWH;
    CGFloat _margin;
}
@end

@implementation TJ_ImagePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemSize = 50;
    layout.itemSize = CGSizeMake(itemSize, itemSize);
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor colorWithWhite:0.914 alpha:1.000];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[TJ_ShowPhotoCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([TJ_ShowPhotoCollectionCell class])];
        _selectedPhotos = [NSMutableArray array];
        _selectedAssets = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark TJ_ShowPhotoCollectionCellDelegate

- (void)didClickDeleteButton:(NSIndexPath *)indexPath
{
    [_selectedPhotos removeObjectAtIndex:indexPath.row];
    [self reloadData];
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TJ_ShowPhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TJ_ShowPhotoCollectionCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.isShowDeleteButton = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.isShowDeleteButton = NO;
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn"];
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) [self pickPhotoButtonClick:nil];
}

- (NSString *)getBytesFromDataLength:(NSInteger)dataLength {
    NSString *bytes;
    if (dataLength >= 0.1 * (1024 * 1024)) {
        bytes = [NSString stringWithFormat:@"%0.1fM", dataLength / 1024 / 1024.0];
    } else if (dataLength >= 1024) {
        bytes = [NSString stringWithFormat:@"%0.0fK", dataLength / 1024.0];
    } else {
        bytes = [NSString stringWithFormat:@"%zdB", dataLength];
    }
    return bytes;
}

#pragma mark Click Event
- (void)pickPhotoButtonClick:(UIButton *)sender {
    AlbumNavigationController *navigation = [[AlbumNavigationController alloc] initWithMaxImagesCount:9 delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [navigation setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
        for (UIImage *image in photos) {
            //如果返回的图片还是太大 可以这样压缩
            NSData *data = UIImageJPEGRepresentation(image, 0.5);
            NSData *oriData = UIImageJPEGRepresentation(image, 1);
            NSLog(@"%@, %@", [self getBytesFromDataLength:data.length], [self getBytesFromDataLength:oriData.length]);
        }
    }];
    
    // Set the appearance
    // 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    navigation.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    navigation.oKButtonTitleColorNormal = [UIColor greenColor];
    
    // Set allow picking video & originalPhoto or not
    // 设置是否可以选择视频/原图
    // imagePickerVc.allowPickingVideo = NO;
    //     imagePickerVc.allowPickingOriginalPhoto = NO;
    
    [self.currentVC presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - 用户点击了取消
- (void)albumNavigationControllerDidCancel:(AlbumNavigationController *)picker {
    // NSLog(@"cancel");
}

/// User finish picking photo，if assets are not empty, user picking original photo.
/// 用户选择好了图片，如果assets非空，则用户选择了原图。
- (void)albumNavigationController:(AlbumNavigationController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets {
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i < photos.count; i++) {
        UIImage *temImage = photos[i];
        NSData *data = UIImageJPEGRepresentation(temImage, 0.1);
        [imageArray addObject:[UIImage imageWithData:data]];
    }
    
    [_selectedPhotos addObjectsFromArray:imageArray];
    [self reloadData];
//    _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

/// User finish picking video,
/// 用户选择好了视频
- (void)albumNavigationController:(AlbumNavigationController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    [_selectedPhotos addObjectsFromArray:@[coverImage]];
    [self reloadData];
//    _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

@end
