//
//  TJ_DetailsViewController.h
//  金堂
//
//  Created by SDKJ on 16/4/28.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJ_BAButton.h"

#define BottonView_H 49

@interface TJ_DetailsBaseViewController : UIViewController

@property (nonatomic, assign) BOOL showBottomView;

@property (nonatomic, strong) NSString *titelString;

@property (nonatomic, strong) TJ_BACustomButton *rightButton;

- (void)didClickRightButton:(TJ_BACustomButton *)sender;

@end
