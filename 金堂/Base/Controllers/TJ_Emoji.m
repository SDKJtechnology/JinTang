//
//  TJ_Emoji.m
//  金堂
//
//  Created by SDKJ on 16/5/5.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_Emoji.h"

@implementation TJ_Emoji

#pragma mark - 表情包字典
+ (NSDictionary *)getEmojiDictionary {
    static NSDictionary *emojiDictionary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *emojiFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"MLEmoji_ExpressionImage.plist"];
        emojiDictionary = [[NSDictionary alloc] initWithContentsOfFile:emojiFilePath];
    });
    return emojiDictionary;
}

#pragma mark - 表情名称数组
+ (NSArray *)getEmojiArray {
    static NSArray *emojiArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *emojiFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"MLEmoji_Expression.plist"];
        emojiArray = [[NSArray alloc] initWithContentsOfFile:emojiFilePath];
    });
    return emojiArray;
}

@end
