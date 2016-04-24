//
//  CommentModel.h
//  金堂
//
//  Created by ZhangAnMing on 16/4/24.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (nonatomic, copy) NSString *commentString;

@property (nonatomic, copy) NSString *firstUserName;
@property (nonatomic, copy) NSString *firstUserId;

@property (nonatomic, copy) NSString *secondUserName;
@property (nonatomic, copy) NSString *secondUserId;

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;

@end
