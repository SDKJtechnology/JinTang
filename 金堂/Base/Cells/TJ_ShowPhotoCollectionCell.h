//
//  TJ_ShowPhotoCollectionCell.h
//  金堂
//
//  Created by SDKJ on 16/5/9.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TJ_ShowPhotoCollectionCellDelegate <NSObject>

- (void)didClickDeleteButton:(NSIndexPath *)indexPath;

@end

@interface TJ_ShowPhotoCollectionCell : UICollectionViewCell

@property (nonatomic, weak) id<TJ_ShowPhotoCollectionCellDelegate> delegate;

@property (nonatomic, strong) UIImageView *imageView;
/**
 *  是否显示删除按钮，默认为YES
 */
@property (nonatomic, assign) BOOL isShowDeleteButton;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
