//
//  TJ_DynamicConcernTableView.h
//  金堂
//
//  Created by SDKJ on 16/4/27.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJ_TableViewModel.h"

typedef void(^DidSelectRowAtIndexPath)(NSIndexPath *);

@interface TJ_DynamicConcernTableView : TJ_TableViewModel

@property (nonatomic, strong) NSMutableArray *dynamicConcernListData;

@property (nonatomic, strong) DidSelectRowAtIndexPath didSelectRowAtIndexPath;

@end
