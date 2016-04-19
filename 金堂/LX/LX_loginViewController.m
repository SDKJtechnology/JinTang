//
//  LX_loginViewController.m
//  金堂
//
//  Created by zouxin on 16/4/14.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "LX_loginViewController.h"
#import <Masonry.h>
#import "LX_login2ViewController.h"

@interface LX_loginViewController ()
@property(nonatomic,strong)UIView *backgroundView;

@end

@implementation LX_loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.backgroundView.hidden = NO;
    
    //UIView *view = [[UIView alloc]init];
    
    //创建微笑的那个圆脸的uiimageView
    UIImage *image = [UIImage imageNamed:@"touxiang"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    //创建登录后去和朋友们聊天吧的那个label
    UILabel *label = [[UILabel alloc]init];
    label.text = @"登录后去和朋友聊天吧";
    
    label.textColor = [UIColor grayColor];
    label.textAlignment = UITextAlignmentCenter;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.font = [UIFont fontWithName:@"HiraKakuProN-w3" size:18];
    label.numberOfLines = 1;
    [label sizeToFit];
    label.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(imageView.mas_bottom).offset(10);
    }];
    
    //创建去登录的那个按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    // loginBtn.frame = CGRectMake(20, 400, 40, 80);
    loginBtn.backgroundColor = [UIColor colorWithRed:0 green:166.0/255 blue:255.0/255 alpha:1];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    loginBtn.layer.cornerRadius = 10.0;
    
    [loginBtn setTitle:@"去登录" forState:UIControlStateNormal];
    [loginBtn setTitle:@"去登录" forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(clicklogin:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(label.mas_width);
        //make.height.mas_equalTo(self.navigationController.navigationBar.mas_height);
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(label.mas_bottom).offset(8);
        
    }];
    
    
}
-(UIView *)backgroundView{
    if (_backgroundView ==nil) {
        _backgroundView = [[UIView alloc]init];
        _backgroundView.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
        [self.view addSubview:_backgroundView];
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(21, 23));
        }];
    }
    return _backgroundView;

}

-(void)clicklogin:(UIButton *)sender{
    NSLog(@"你点对了，我擦");
    LX_login2ViewController *login2 = [LX_login2ViewController new];
    login2.view.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
    [self.navigationController pushViewController:login2 animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
