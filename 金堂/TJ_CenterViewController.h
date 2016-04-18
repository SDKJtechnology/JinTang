//
//  CenterNacigationController.h
//  金堂
//
//  Created by ZhangAnMing on 16/4/4.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJ_LeftSlideViewController.h"
#import "SDAutoLayout.h"

#define statusBarFrame [[UIApplication sharedApplication] statusBarFrame]//状态栏frame
#define navigationBarFrame self.navigationController.navigationBar.frame//navigationbar frame

@interface TJ_CenterViewController : UIViewController

- (void) openOrCloseLeftList;

@end
