//
//  TopicModel.m
//  金堂
//
//  Created by SDKJ on 16/4/15.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel

- (instancetype)init
{
    if (self = [super init]) {
        self.titleString = @"史蒂夫圣诞节啊风口浪尖";
        self.browseCount = @"2435";
        self.supportCount = @"546";
        self.sharedImageUrls = @[@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png",@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png"];
    }
    
    return self;
}

@end
