//
//  TJ_ShowPhotoCollectionCell.m
//  金堂
//
//  Created by SDKJ on 16/5/9.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_ShowPhotoCollectionCell.h"

@implementation TJ_ShowPhotoCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}

@end
