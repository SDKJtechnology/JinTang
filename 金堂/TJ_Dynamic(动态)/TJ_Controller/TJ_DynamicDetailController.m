//
//  TJ_DynamicDetailController.m
//  金堂
//
//  Created by SDKJ on 16/4/28.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_DynamicDetailController.h"
#import "UIView_extra.h"

@interface TJ_DynamicDetailController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation TJ_DynamicDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat height = self.view.height - 64 - BottonView_H;
    if (!self.showBottomView){
        height += BottonView_H;
    }
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, height)];
    [self.view insertSubview:_webView atIndex:0];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [_webView loadRequest:request];
}

- (void)didClickRightButton:(TJ_BACustomButton *)sender
{
    NSLog(@"TJ_DynamicDetailController");
}

@end
