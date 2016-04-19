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
#import <RongIMKit/RCConversationViewController.h>
#import "LX_ChatListViewController.h"
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
    [_loginBtn addTarget:self action:@selector(clickloginChat) forControlEvents:UIControlEventTouchUpInside];
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

-(void)clickloginChat{
    NSLog(@"你点击了开始聊天的这个按钮");
     //登录融云服务器,开始阶段可以先从融云API调试网站获取，之后token需要通过服务器到融云服务器取。
     NSString*token=@"1Cv7TsY7T7wW4kksjL6p8UmcbyeYIrXSDa0nFvL2mH/U5nPXuaB+12S6/5HoVCjf2GXR/ibrED8=";
    
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        NSLog(@"Login successfully with userId: %@.", userId);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            LX_ChatListViewController *chatListViewController = [LX_ChatListViewController new];
            chatListViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:chatListViewController animated:YES];
           
        });
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"login error status: %ld.", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
    }];
    
    
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
/**
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
-(void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    //此处为了演示写了一个用户信息
    if ([@"1" isEqualToString:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"1";
        user.name = @"测试1";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        return completion(user);
    
    }else if ([@"2" isEqualToString:userId]){
        
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"2";
        user.name = @"测试2";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        return completion(user);
        
    }
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
