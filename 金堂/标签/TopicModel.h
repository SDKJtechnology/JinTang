//
//  TopicModel.h
//  金堂
//
//  Created by SDKJ on 16/4/15.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject

@property (nonatomic, strong) NSString *titleString;

@property (nonatomic, strong) NSArray *sharedImageUrls;

@property (nonatomic, strong) NSString *browseCount;

@property (nonatomic, strong) NSString *supportCount;

@property (nonatomic, assign) NSInteger ID;


@end
