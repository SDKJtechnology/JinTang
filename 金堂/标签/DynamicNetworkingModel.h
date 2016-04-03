//
//  DynamicDataModel.h
//  金堂
//
//  Created by ZhangAnMing on 16/3/31.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^DynamicNetworkingBlock)(id data);

@interface DynamicNetworkingModel : NSObject

@property (nonatomic, copy) DynamicNetworkingBlock dynamicListBlock;

+ (instancetype)sharedObejct;

- (void)getDynamicDataWithPage:(NSNumber *)page;

@end
