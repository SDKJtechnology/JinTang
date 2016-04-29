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
        
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 130)];
//    [self.view addSubview:_webView];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [_webView loadRequest:request];
}

- (void)didClickRightButton:(TJ_BACustomButton *)sender
{
    NSLog(@"TJ_DynamicDetailController");
}

@end
