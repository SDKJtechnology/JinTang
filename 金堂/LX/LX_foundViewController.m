//
//  LX_foundViewController.m
//  金堂
//
//  Created by zouxin on 16/4/18.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "LX_foundViewController.h"
#import <Masonry.h>
#import "LX_QRCodeViewController.h"
#import "LX_MendViewController.h"
@interface LX_foundViewController ()
@property(nonatomic,strong)UIView *backgroundView;
@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UIButton *btn1;

@property(nonatomic,strong)UIButton *btn2;

@property(nonatomic,strong)UIButton *btn3;
@property(nonatomic,strong)UIButton *btn4;

@property(nonatomic,strong)UILabel *label2;

//创建中间的4个按钮
@property(nonatomic,strong)UIButton *btn5;
@property(nonatomic,strong)UIButton *btn6;
@property(nonatomic,strong)UIButton *btn7;
@property(nonatomic,strong)UIButton *btn8;

//创建查询服务的那个label3
@property(nonatomic,strong)UILabel *label3;


@property(nonatomic,strong)UIButton *btn9;
@property(nonatomic,strong)UIButton *btn10;
@property(nonatomic,strong)UIButton *btn11;
@property(nonatomic,strong)UIButton *btn12;@end

@implementation LX_foundViewController

-(UIView *)backgroundView{
    if (_backgroundView ==nil) {
        _backgroundView = [[UIView alloc]init];
        _backgroundView.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
        [self.view addSubview:_backgroundView];
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(21, 23));
        }];
        
    }//18111266446
    return _backgroundView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundView.hidden = NO;
    
    self.label1.hidden = NO;
    
    //创建导航栏右上角的那个具有二维码扫描功能的按钮
    
   UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"erweima"] style:UIBarButtonItemStylePlain target:self action:@selector(clickQRCode:)];
   
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    
    _label1 = [[UILabel alloc]init];
    _label1.text = @"热点推荐";
    _label1.textColor = [UIColor blackColor];
    _label1.backgroundColor = [UIColor clearColor];
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.lineBreakMode = NSLineBreakByWordWrapping;
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.lineBreakMode = NSLineBreakByWordWrapping;
    _label1.font = [UIFont fontWithName:@"AppleGothic" size:18];
    _label1.numberOfLines = 1;
    [_label1 sizeToFit];
    _label1.adjustsFontSizeToFitWidth = YES;
    _label1.userInteractionEnabled = YES;
    [self.view addSubview:_label1];
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(self.view.mas_left).offset(10);
       
        
        make.centerY.mas_equalTo(self.view.mas_centerY).multipliedBy(0.35);
    }];
    //创建第一行的四个按钮
    
    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ai"]];
    [_btn1 addTarget:self action:@selector(clickOne:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn1];
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.25);
        make.top.mas_equalTo(_label1.mas_bottom).offset(10);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.15);
    }];
    
    _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"didi"]];
    [_btn2 addTarget:self action:@selector(clictwo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn2];
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_btn1.mas_right).offset(1);
        make.width.mas_equalTo(_btn1.mas_width);
        make.top.mas_equalTo(_btn1.mas_top);
        
        make.height.mas_equalTo(_btn1.mas_height);
    }];
    
    _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lukuang"]];
    [_btn3 addTarget:self action:@selector(clickThree:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn3];
    
    [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_btn2.mas_right).offset(1);
        make.width.mas_equalTo(_btn1.mas_width);
        make.top.mas_equalTo(_btn1.mas_top);
        
        make.height.mas_equalTo(_btn1.mas_height);
    }];
    
    _btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"redian"]];
    [_btn4 addTarget:self action:@selector(clickThree:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn4];
    
    [_btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_btn3.mas_right).offset(1);
        make.width.mas_equalTo(_btn1.mas_width);
        make.top.mas_equalTo(_btn1.mas_top);
        
        make.height.mas_equalTo(_btn1.mas_height);
    }];
    //创建生活服务的那个标签
    
    _label2 = [[UILabel alloc]init];
    _label2.text = @"生活服务";
    _label2.textColor = [UIColor blackColor];
    _label2.backgroundColor = [UIColor clearColor];
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.lineBreakMode = NSLineBreakByWordWrapping;
    _label2.font = [UIFont fontWithName:@"AppleGothic" size:18];
    _label2.numberOfLines = 1;
    [_label2 sizeToFit];
    _label2.adjustsFontSizeToFitWidth = YES;
    _label2.userInteractionEnabled = YES;
    [self.view addSubview:_label2];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_label1.mas_left);
        make.top.mas_equalTo(_btn1.mas_bottom).offset(10);
    }];
    
    
    
    _btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shenghuo"]];
    [_btn5 addTarget:self action:@selector(clickFive:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn5];
    [_btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_btn1.mas_left);
        make.top.mas_equalTo(_label2.mas_bottom).offset(10);
        make.height.mas_equalTo(_btn1.mas_height);
        make.width.mas_equalTo(_btn1.mas_width);
        
    }];
    
    _btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn6.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tingdian"]];
    [_btn6 addTarget:self action:@selector(clickFive:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn6];
    [_btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btn5.mas_top);
        make.left.mas_equalTo(_btn5.mas_right).offset(1);
        
        make.height.mas_equalTo(_btn5.mas_height);
        make.width.mas_equalTo(_btn5.mas_width);
    }];
    
    _btn7 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn7.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"weizhang"]];
    [_btn7 addTarget:self action:@selector(clickSeven:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn7];
    [_btn7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btn5.mas_top);
        make.left.mas_equalTo(_btn6.mas_right).offset(1);
        make.height.mas_equalTo(_btn5.mas_height);
        make.width.mas_equalTo(_btn5.mas_width);
        
    }];
    
    _btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xinshou"]];
    [_btn8 addTarget:self action:@selector(clickdidi:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn8];
    [_btn8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btn5.mas_top);
        
        make.left.mas_equalTo(_btn7.mas_right).offset(1);
        make.height.mas_equalTo(_btn5.mas_height);
        make.width.mas_equalTo(_btn5.mas_width);
    }];
    
    
    _label3 = [[UILabel alloc]init];
    _label3.text = @"查询服务";
    _label3.textColor = [UIColor blackColor];
    _label3.backgroundColor = [UIColor clearColor];
    _label3.textAlignment = NSTextAlignmentCenter;
    _label3.lineBreakMode = NSLineBreakByWordWrapping;
    _label3.font = [UIFont fontWithName:@"AppleGothic" size:18];
    _label3.numberOfLines = 1;
    [_label3 sizeToFit];
    _label3.adjustsFontSizeToFitWidth = YES;
    _label3.userInteractionEnabled = YES;
    [self.view addSubview:_label3];
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_label2.mas_left);
        make.top.mas_equalTo(_btn5.mas_bottom).offset(10);
    }];
    
    
    _btn9 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn9.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yaopin"]];
    // [_btn9 addTarget:self action:@selector(clickNine:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn9];
    [_btn9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_btn5.mas_left);
        make.top.mas_equalTo(_label3.mas_bottom).offset(10);
        make.width.mas_equalTo(_btn5.mas_width);
        make.height.mas_equalTo(_btn5.mas_height);
    }];
    
    _btn10 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn10.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yonghuming"]];
    [_btn10 addTarget:self action:@selector(clickName:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn10];
    [_btn10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_btn9.mas_right).offset(1);
        make.top.mas_equalTo(_btn9.mas_top);
        make.width.mas_equalTo(_btn5.mas_width);
        make.height.mas_equalTo(_btn5.mas_height);
    }];
    
    _btn11 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn11.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Icon-60"]];
    //[_btn11 addTarget:self action:@selector(clickeleven:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn11];
    [_btn11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_btn10.mas_right).offset(1);
        make.top.mas_equalTo(_btn10.mas_top);
        make.width.mas_equalTo(_btn10.mas_width);
        make.height.mas_equalTo(_btn10.mas_height);
    }];
    
    _btn12 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn12.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Icon-60"]];
    // [_btn12 addTarget:self action:@selector(clickeleven:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn12];
    [_btn12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_btn11.mas_right).offset(1);
        make.top.mas_equalTo(_btn10.mas_top);
        make.width.mas_equalTo(_btn10.mas_width);
        make.height.mas_equalTo(_btn10.mas_height);
    }];
    

}
-(void)clickdidi:(UIButton *)sender{
    NSLog(@"这滴滴的一个点击的一张图片");
    
}
-(void)clickVIP:(UIBarButtonItem *)sender{
    NSLog(@"输出的是人的头像");
    
}
-(void)clickQRCode:(UIBarButtonItem *)sender{
    NSLog(@"点击了后就会产生二维码扫描功能");
   
    
    LX_QRCodeViewController *codeViewController = [LX_QRCodeViewController new];
    codeViewController.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    
    [self presentViewController:codeViewController animated:YES completion:nil];
    
    
    
}
-(void)clickName:(UIButton *)sender{
    NSLog(@"点击的是修改用户名的那个框");
    LX_MendViewController *mendViewController = [LX_MendViewController new];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mendViewController animated:YES];
    
    
}
@end
