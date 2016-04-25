//
//  CommentModel.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/24.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

- (instancetype)init
{
    if (self = [super init]) {
        self.commentString = @"刘邦海是煞笔";
        self.secondUserName = @"小海";
        self.secondUserId = @"1212";
        
        self.firstUserName = @"小黑";
        self.firstUserId = @"5454";
        
        self.userId = @"111";
        self.userName = @"史蒂夫";
    }
    
    return self;
}

@end
