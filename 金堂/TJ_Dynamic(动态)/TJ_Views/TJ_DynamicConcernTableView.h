//
//  TJ_DynamicConcernTableView.h
//  金堂
//
//  Created by SDKJ on 16/4/27.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSelectRowAtIndexPath)(NSIndexPath *);

@interface TJ_DynamicConcernTableView : UITableView

@property (nonatomic, strong) NSArray *dynamicConcernListData;

@property (nonatomic, strong) DidSelectRowAtIndexPath didSelectRowAtIndexPath;

@end
