//
//  TJ_ShowPhotoCollectionCell.m
//  金堂
//
//  Created by SDKJ on 16/5/9.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_ShowPhotoCollectionCell.h"

@interface TJ_ShowPhotoCollectionCell()

@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation TJ_ShowPhotoCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.backgroundColor = [UIColor redColor];
        [_deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteButton];
        _isShowDeleteButton = YES;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    CGFloat w = 20;
    _deleteButton.frame = CGRectMake(self.bounds.size.width - w, 0, w, w);
    _deleteButton.layer.cornerRadius = w * 0.5f;
}

- (void)deleteButtonAction:(UIButton *)deleteButton
{
    if ([self.delegate respondsToSelector:@selector(didClickDeleteButton:)]){
        [self.delegate didClickDeleteButton:self.indexPath];
    }
}

- (void)setIsShowDeleteButton:(BOOL)isShowDeleteButton
{
    _deleteButton.hidden = !isShowDeleteButton;
}

@end
