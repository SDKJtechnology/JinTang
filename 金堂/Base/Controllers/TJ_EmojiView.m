//
//  TJ_EmojiView.m
//  金堂
//
//  Created by SDKJ on 16/5/5.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_EmojiView.h"
#import "UIView_extra.h"
#import "TJ_Emoji.h"

@interface TJ_EmojiView()<
                        UICollectionViewDelegate,
                        UICollectionViewDataSource>
{
    NSMutableArray *emojiArray;
    NSDictionary *emojiDictionary;
}

@end

@implementation TJ_EmojiView

- (instancetype)initWithFrame:(CGRect)frame{
    CGFloat itemSize = 30;
    CGFloat lineSpacing = (frame.size.width - 7 * itemSize) / 7;
    CGFloat leftMargin = lineSpacing * 0.5;
    CGFloat itemSpacing = (frame.size.height - 3 * itemSize) / 4;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = lineSpacing;
    flowLayout.minimumInteritemSpacing = itemSpacing;
    flowLayout.itemSize = CGSizeMake(itemSize, itemSize);
    flowLayout.sectionInset = UIEdgeInsetsMake(itemSpacing, leftMargin, itemSpacing, leftMargin);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    if (self = [super initWithFrame:frame collectionViewLayout:flowLayout]) {
        self.delegate = self;
        self.dataSource = self;
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        NSArray *array = [TJ_Emoji getEmojiArray];
        emojiDictionary = [TJ_Emoji getEmojiDictionary];
        NSString *bundle = [[NSBundle mainBundle] resourcePath];
        emojiArray = [NSMutableArray array];
        NSString *s = @"";
        for (NSString *name in array) {
            NSString *string = emojiDictionary[name];
            NSString *st =[NSString stringWithFormat:@"%@@2x.png,%@\n",string,name];
            s = [s stringByAppendingString:st];
//            printf("%s","sdfsdf");
            NSString *path = [bundle stringByAppendingPathComponent:[NSString stringWithFormat:@"MLEmoji_Expression.bundle/%@",emojiDictionary[name]]];
            [emojiArray addObject:path];
        }
        NSLog(@"%@",s);
    }
    
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return emojiArray.count + emojiArray.count / 21 + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    NSInteger i = indexPath.item / 21;
    UIImage *image;
    if (indexPath.item == ((i + 1) * 21 - 1) || indexPath.item == (emojiArray.count + emojiArray.count / 21)) {
        image = [UIImage imageNamed:@"faceDelete"];
    }
    else{
        image = [UIImage imageNamed:emojiArray[indexPath.item - i]];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.backgroundView = imageView;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isDelete = NO;
    if (indexPath.item == ((indexPath.item / 21 + 1) * 21 - 1) || indexPath.item == (emojiArray.count + emojiArray.count / 21)) {
        isDelete = YES;
    }
    if ([self.delegateEmojiView respondsToSelector:@selector(didSelectedEmojiImagePath:isDelete:)]) {
        [self.delegateEmojiView didSelectedEmojiImagePath:emojiArray[indexPath.item - indexPath.item / 21] isDelete:isDelete];
    }
}

@end
