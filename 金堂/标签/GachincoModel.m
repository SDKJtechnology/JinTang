//
//  GachincoModel.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/16.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "GachincoModel.h"

@implementation GachincoModel


- (instancetype)init:(NSInteger)i
{
    if (self = [super init]) {
        
        if (!(i % 3)) {
            self.sharedImageUrls = @[@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png",@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png",@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png"];
        }
        else if (!(i % 2))
            self.sharedImageUrls = @[@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png",@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png"];
        else
            self.sharedImageUrls = @[@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png"];
        
        self.sourceName = @"似懂非懂说";
        self.timeString = @"10分钟前";
        self.addressesSting = @"三江路红灯区";
        self.titleString = @"卢卡斯飞机上的纠纷克里斯蒂减肥";
        self.headImageUrl = @"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png";
        i++;
        
    }
                
    return self;
}
                

@end
