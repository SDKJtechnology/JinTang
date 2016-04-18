//
//  LX_login2ViewController.m
//  金堂
//
//  Created by zouxin on 16/4/14.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "LX_login2ViewController.h"
#import <Masonry.h>
#import "LX_enrollViewController.h"
#import "UMSocial.h"
#define kUMKey    @"5657f8a367e58e3b660032d7"

@interface LX_login2ViewController ()

@property(nonatomic,strong)UITextField *textFieldAccount;

@property(nonatomic,strong)UITextField *textFieldPassword;

@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *enrollBtn;
@property(nonatomic,strong)UIButton *forgetBtn;
@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)UIButton *qqBtn;

@end

@implementation LX_login2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"登陆";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建输入框的那个背景图
    
    UIImage *image1 = [UIImage imageNamed:@"kongbai"];
    UIImageView *imageView1 = [[UIImageView alloc]initWithImage:image1];
    [self.view addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).multipliedBy(0.48);
    }];
    
    //创建左边的那个用户名的图标
    UIImageView *leftVN = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dongtai"]];
    leftVN.contentMode = UIViewContentModeCenter;
    [self.view addSubview:leftVN];
    [leftVN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageView1.mas_centerY);
        
        
        make.left.mas_equalTo(imageView1.mas_left).offset(10);
    }];
    
    //创建请输入用户名的那个textfield
    _textFieldAccount = [[UITextField alloc]init];
    
    _textFieldAccount.backgroundColor = [UIColor clearColor];
    _textFieldAccount.placeholder = @"请输入用户名/手机号";
    _textFieldAccount.textAlignment = UITextAlignmentCenter;
    _textFieldAccount.borderStyle = UITextBorderStyleRoundedRect;
    _textFieldAccount.font = [UIFont systemFontOfSize:18];
    _textFieldAccount.adjustsFontSizeToFitWidth = YES;
    _textFieldAccount.keyboardType = UIKeyboardTypeNumberPad;
    _textFieldAccount.returnKeyType = UIReturnKeyDone;//设置键盘的完成按钮
    
    _textFieldAccount.delegate = self;
    [_textFieldAccount addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_textFieldAccount];
    [_textFieldAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(imageView1.mas_centerX);
        make.width.mas_equalTo(imageView1.mas_width);
        //make.top.mas_equalTo(imageView1.mas_top);
        make.centerY.mas_equalTo(imageView1.mas_centerY);
        make.height.mas_equalTo(imageView1.mas_height);
    }];
    
    //创建第二个输入框的的那个背景图
    
    UIImage *image2 = [UIImage imageNamed:@"kongbai"];
    UIImageView *imageView2 = [[UIImageView alloc]initWithImage:image2];
    [self.view addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(imageView1.mas_bottom).offset(10);
    }];
    
    //创建imageView2左边的那个背景图
    
    UIImageView *leftVP = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suo"]];
    leftVP.contentMode = UIViewContentModeCenter;
    [self.view addSubview:leftVP];
    [leftVP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageView2.mas_centerY);
        make.left.mas_equalTo(imageView2.mas_left).offset(10);
        
    }];
    
    //创建请输入密码的那个textfield
    
    _textFieldPassword = [[UITextField alloc]init];
    _textFieldPassword.backgroundColor = [UIColor clearColor];
    _textFieldPassword.placeholder = @"请输入密码";
    _textFieldPassword.textAlignment = UITextAlignmentCenter;
    _textFieldPassword.borderStyle = UITextBorderStyleRoundedRect;
    _textFieldPassword.font = [UIFont systemFontOfSize:18];
    _textFieldPassword.adjustsFontSizeToFitWidth = YES;
    _textFieldPassword.keyboardType = UIKeyboardTypeNumberPad;
    _textFieldPassword.returnKeyType = UIReturnKeyDone;//设置键盘的完成按钮
    
    _textFieldPassword.delegate = self;
    [_textFieldPassword addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_textFieldPassword];
    [_textFieldPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(imageView2.mas_centerX);
        make.width.mas_equalTo(imageView2.mas_width);
        //make.top.mas_equalTo(imageView1.mas_top);
        make.centerY.mas_equalTo(imageView2.mas_centerY);
        make.height.mas_equalTo(imageView2.mas_height);
    }];
    
    //创建登录的那个按钮
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.backgroundColor = [UIColor colorWithRed:0/255 green:166.0/255 blue:255.0/255 alpha:1];
    
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(clicklogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView1.mas_centerX);
        make.height.mas_equalTo(imageView1.mas_height).multipliedBy(0.5);
        make.top.mas_equalTo(imageView2.mas_bottom).offset(20);
        make.width.mas_equalTo(imageView1.mas_width);
    }];
    //创建登录下面的那个注册按钮
    
    
    _enrollBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    // loginBtn.frame = CGRectMake(20, 400, 40, 80);
    _enrollBtn.backgroundColor = [UIColor clearColor];
    
    [_enrollBtn setTitleColor:[UIColor colorWithRed:174.0/255 green:174.0/255 blue:174.0/255 alpha:1] forState:UIControlStateNormal];
    
    // enrollBtn.layer.cornerRadius = 10.0;
    
    [_enrollBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [_enrollBtn addTarget:self action:@selector(clickEnroll:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_enrollBtn];
    [_enrollBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_loginBtn);
        make.top.mas_equalTo(_loginBtn.mas_bottom).offset(20);
    }];
    
    //创建忘记密码的那个按钮
    _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _forgetBtn.backgroundColor = [UIColor clearColor];
    [_forgetBtn setTitleColor:[UIColor colorWithRed:174.0/255 green:174.0/255 blue:174.0/255 alpha:1] forState:UIControlStateNormal];
    
    // enrollBtn.layer.cornerRadius = 10.0;
    
    [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_forgetBtn addTarget:self action:@selector(clickforget:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_forgetBtn];
    [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_loginBtn.mas_right);
        make.bottom.mas_equalTo(_enrollBtn.mas_bottom);
    }];
    
    //创建使用第三方登录的线
    UIImage *image = [UIImage imageNamed:@"tupian"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_forgetBtn.mas_bottom).offset(40);
    }];
    
    //创建使用第三登录下面的那根线下面的那个qq的按钮
    
    
    _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    // loginBtn.frame = CGRectMake(20, 400, 40, 80);
    _qqBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qq"]];
    
    [_qqBtn addTarget:self action:@selector(clickqq:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_qqBtn];
    [_qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
}

- (void)clickforget:(UIButton *)sender
{
    NSLog(@"点击忘记密码");
}
-(void)clicklogin:(UIButton *)sender{
    NSLog(@"这个登录按钮");
}
-(void)clickqq:(UIButton *)sender{
    NSLog(@"你点了这个头像了");
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
        }});

    
}
-(void)clickEnroll:(UIButton *)sender{
    NSLog(@"这是一个注册的页面");
    LX_enrollViewController *enroll = [LX_enrollViewController new];
    
    //[self presentViewController:enroll animated:YES completion:nil];
    
    
//    LX_login2ViewController *login2 = [LX_login2ViewController new];
//    login2.view.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
//    [self.navigationController pushViewController:login2 animated:YES];
    
    enroll.view.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
    [self.navigationController pushViewController:enroll animated:YES];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
