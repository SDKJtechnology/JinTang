
//  TJ_ SharedPhotoView.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/12.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_SharedPhotoView.h"
#import "SDAutoLayout.h"
#import "UIImageView+WebCache.h"

#define margin 10

@interface TJ__SharedPhotoView()
{
    NSMutableArray *imageViews;
}

@end

@implementation TJ__SharedPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    imageViews = [NSMutableArray array];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [imageViews addObject:imageView];
    }
}

- (void)setImageUrlArray:(NSArray *)imageUrlArray
{
    _imageUrlArray = imageUrlArray;
    
    for (long i = imageUrlArray.count; i < imageViews.count; i++) {
        UIImageView *imageView = [imageViews objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (imageUrlArray.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    CGFloat itemH = [self itemWidthForPicPathArray:imageUrlArray];
    
    NSInteger perRowItemCount = [self perRowItemCountForPicPathArray:imageUrlArray];
    NSInteger idx = 0;
    for (NSString *obj in imageUrlArray)
    {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [imageViews objectAtIndex:idx];
        imageView.hidden = NO;
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:[UIImage imageNamed:@"load"]];
        if (imageUrlArray.count == 1)
            itemH = imageView.image.size.height / imageView.image.size.width * itemH;
//        imageView.image = [UIImage imageNamed:obj];
        imageView.frame = CGRectMake(columnIndex * (itemH + margin), rowIndex * (itemH + margin), itemH, itemH);
        idx++;
    };
    float count = (float)imageUrlArray.count / perRowItemCount;
    if (count > (float)imageUrlArray.count / perRowItemCount)
        count++;
    NSInteger columnCount = roundf(count);
    CGFloat h = columnCount * (itemH + margin);
    
    self.height = h;
    self.fixedHeight = @(h);
}

#pragma mark - private actions

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
//    UIView *imageView = tap.view;
    NSLog(@"点击照片");
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1) {
        return 120;
    } else {
        CGFloat w = (self.width - 2 * margin) / 3;
        return w;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count <= 3) {
        return array.count;
    } else if (array.count == 4) {
        return 2;
    } else {
        return 3;
    }
}

@end
