//
//  TJ_DetailsViewController.h
//  金堂
//
//  Created by SDKJ on 16/4/28.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJ_BAButton.h"


@interface TJ_DetailsBaseViewController : UIViewController

@property (nonatomic, strong) NSString *titelString;

@property (nonatomic, strong) TJ_BACustomButton *rightButton;

- (void)didClickRightButton:(TJ_BACustomButton *)sender;

@end
