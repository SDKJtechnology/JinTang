//
//  TJ_EmojiView.h
//  金堂
//
//  Created by SDKJ on 16/5/5.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TJ_EmojiViewDelegate <NSObject>
//已经选中表情图片
- (void)didSelectedEmojiImagePath:(NSString *)emojiImagePath isDelete:(BOOL)deleted;

@end

@interface TJ_EmojiView : UICollectionView

@property (nonatomic, weak) id<TJ_EmojiViewDelegate> delegateEmojiView;

@end
