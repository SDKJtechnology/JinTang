//
//  SupportTarentoModel.m
//  金堂
//
//  Created by SDKJ on 16/4/25.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "SupportTarentoModel.h"

@implementation SupportTarentoModel

- (instancetype)init
{
    if (self = [super init]) {
        self.imagesArray = @[@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png" ,@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png",@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png",@"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png"];
        self.userImageUrl = @"http://7xn4qj.com1.z0.glb.clouddn.com/_20160203141820_56b19bac58683.png";
        
        self.userNameString = @"伤口恢复速度加快";
        
        self.detailString = @"水电费水电费";
    }
    
    return self;
}

@end
