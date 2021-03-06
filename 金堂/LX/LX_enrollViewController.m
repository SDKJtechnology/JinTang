//
//  LX_enrollViewController.m
//  金堂
//
//  Created by zouxin on 16/4/15.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "LX_enrollViewController.h"
#import <Masonry.h>
#import <SMS_SDK/SMSSDK.h>
#import "LX_enroll2ViewController.h"
@interface LX_enrollViewController ()
@property(nonatomic,strong)UITextField *textFieldAccount;

@property(nonatomic,strong)UITextField *textFieldPassword;

@property(nonatomic,strong)UIButton *nextBtn;
//创建获取验证码的那个按钮

@property(nonatomic,strong)UIButton *getBtn;

//创建请输入验证码的那个textfield



/** 保存倒计时的时长 */
@property (nonatomic, assign) NSInteger secondsCountDown;

/** 定时器对象 */
@property (nonatomic, strong) NSTimer *countDownTimer;
//创建一个label显示输出的时间是错误的
@property(nonatomic,strong)UILabel *label;

//创建第二个label,显示输出的格式是错误的
@property(nonatomic,strong)UILabel *label2;
@end

@implementation LX_enrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建输入框的那个背景图
    
    UIImage *image1 = [UIImage imageNamed:@"kongbai"];
    UIImageView *imageView1 = [[UIImageView alloc]initWithImage:image1];
    [self.view addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).multipliedBy(0.48);
    }];
    
    //创建左边的那个手机的图标
    
    UIImageView *leftVN = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shoji"]];
    leftVN.contentMode = UIViewContentModeCenter;
    [self.view addSubview:leftVN];
    [leftVN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageView1.mas_centerY);
        
        
        make.left.mas_equalTo(imageView1.mas_left).offset(10);
    }];
    
    //创建请输入手机号的那个textField
    
    _textFieldAccount = [[UITextField alloc]init];
    
    _textFieldAccount.backgroundColor = [UIColor clearColor];
    _textFieldAccount.placeholder = @"请输入用户名/手机号";
    _textFieldAccount.textAlignment = NSTextAlignmentCenter;
    _textFieldAccount.borderStyle = NSLineBreakByWordWrapping;
    _textFieldAccount.font = [UIFont systemFontOfSize:18];
    _textFieldAccount.adjustsFontSizeToFitWidth = YES;
    _textFieldAccount.keyboardType = UIKeyboardTypeNumberPad;
    _textFieldAccount.returnKeyType = UIReturnKeyDone;//设置键盘的完成按钮
    
   // _textFieldAccount.delegate = self;
    [_textFieldAccount addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_textFieldAccount];
    [_textFieldAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(imageView1.mas_centerX);
        make.width.mas_equalTo(imageView1.mas_width);
        //make.top.mas_equalTo(imageView1.mas_top);
        make.centerY.mas_equalTo(imageView1.mas_centerY);
        make.height.mas_equalTo(imageView1.mas_height);
    }];
    
    //创建第二个输入框的背景图
    
    UIImage *image2 = [UIImage imageNamed:@"kongbai"];
    UIImageView *imageView2 = [[UIImageView alloc]initWithImage:image2];
    [self.view addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(imageView1.mas_bottom).offset(10);
    }];
    
     //创建imageView2左边的那个背景图
    UIImageView *leftVP = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xinfeng"]];
    leftVP.contentMode = UIViewContentModeCenter;
    [self.view addSubview:leftVP];
    [leftVP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageView2.mas_centerY);
        make.left.mas_equalTo(imageView2.mas_left).offset(10);
    }];
    //创建请输入验证码的那个背景
    
    _textFieldPassword = [[UITextField alloc]init];
    _textFieldPassword.backgroundColor = [UIColor clearColor];
    _textFieldPassword.placeholder = @"请输入验证码";
    _textFieldPassword.textAlignment = NSTextAlignmentCenter;
    _textFieldPassword.borderStyle = NSLineBreakByWordWrapping;
    _textFieldPassword.font = [UIFont systemFontOfSize:18];
    _textFieldPassword.adjustsFontSizeToFitWidth = YES;
    _textFieldPassword.keyboardType = UIKeyboardTypeNumberPad;
    _textFieldPassword.returnKeyType = UIReturnKeyDone;//设置键盘的完成按钮
    
  //  _textFieldPassword.delegate = self;
   // [_textFieldPassword addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_textFieldPassword];
    [_textFieldPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(imageView2.mas_centerX);
        make.width.mas_equalTo(imageView2.mas_width);
        //make.top.mas_equalTo(imageView1.mas_top);
        make.centerY.mas_equalTo(imageView2.mas_centerY);
        make.height.mas_equalTo(imageView2.mas_height);
    }];
    
    //创建下一步的那个按钮
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.backgroundColor = [UIColor colorWithRed:0/255 green:166.0/255 blue:255.0/255 alpha:1];
    
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(clicknext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView1.mas_centerX);
        make.height.mas_equalTo(imageView1.mas_height).multipliedBy(0.5);
        make.top.mas_equalTo(imageView2.mas_bottom).offset(20);
        make.width.mas_equalTo(imageView1.mas_width);
    }];
    
    _getBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 60, 70, 80)];
    _getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_getBtn setBackgroundColor:[UIColor grayColor]];
    
    [_getBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_getBtn];
    [_getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_textFieldAccount.mas_right).offset(-5);
        make.centerY.mas_equalTo(_textFieldAccount.mas_centerY);
    }];
    
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string{
    NSString *toString = _textFieldAccount.text;
    if (toString.length <10||toString.length>10) {
        NSLog(@"123455");
        
        _getBtn.backgroundColor = [UIColor grayColor];
        _getBtn.userInteractionEnabled = NO;
        [_getBtn addTarget:self action:@selector(clickgetCode) forControlEvents:UIControlEventTouchUpInside];
    }else if(toString.length ==10){
        _getBtn.backgroundColor = [UIColor greenColor];
        
        _getBtn.userInteractionEnabled = YES;
        [_getBtn addTarget:self action:@selector(clickgetCode2) forControlEvents:UIControlEventTouchUpInside];
        
        //_secondsCountDown = 10;
        
        //        //设置倒计时显示时间
        //        _getBtn.titleLabel.text =[NSString stringWithFormat:@"%ld",(long)_secondsCountDown];
        //
        //        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        
        
    }
    
    return YES;
    
}
-(void)clickgetCode{
    NSLog(@"这是不可点");
}

//这个状态是可点，也是可以获取验证码的那个按钮的点击的方法
-(void)clickgetCode2{
    
    NSLog(@"这是可点的正确的状态");
    NSString *codeString = _textFieldAccount.text;
    NSLog(@"codeString是:%@",codeString);
    
    if (codeString.length <11||codeString.length>11) {
        
        NSLog(@"你输入的是错误的号码");
        _label2 = [[UILabel alloc]init];
        _label2.autoresizingMask =UIViewAutoresizingFlexibleWidth;
        _label2.text = @"请输入正确的手机号码格式";
        _label2.textColor = [UIColor redColor];
        _label2.font =[UIFont fontWithName:@"AmericanTypewriter" size:18];
        _label2.numberOfLines = 1;
        [_label2 sizeToFit];
        
        _label2.adjustsFontSizeToFitWidth = YES;
        _label2.userInteractionEnabled = YES;
        
        [self.view addSubview:_label2];
        [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_textFieldAccount.mas_centerX);
            make.bottom.mas_equalTo(_textFieldAccount.mas_top).offset(2);
        }];
        
    }else{
        //定时器验证码将会在10s内发送给你
        _secondsCountDown = 10;
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:codeString zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (error) {
                
                NSLog(@"手机号码是错误的error %@", error);
                _label = [[UILabel alloc]init];
                _label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                _label.text = @"验证码发送失败请重新输入";
                _label.textColor = [UIColor redColor];
                _label.font = [UIFont fontWithName:@"AmericanTypewriter" size:18];
                _label.numberOfLines = 1;
                [_label sizeToFit];
                
                _label.adjustsFontSizeToFitWidth = YES;
                _label.userInteractionEnabled = YES;
                
                [self.view addSubview:_label];
                [_label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(_textFieldAccount.mas_centerX);
                    make.bottom.mas_equalTo(_textFieldAccount.mas_top).offset(2);
                    
                }];
                
            }else{
                //创建验证码
                
                NSLog(@"验证码发送成功!");
                
                _getBtn.titleLabel.lineBreakMode =NSLineBreakByWordWrapping;
                _getBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                [_getBtn setTitle:@"验证码已发送" forState:UIControlStateNormal];
                
            }
        }];
        
        
    }
    
}
-(void)timeFireMethod{
    //倒计时-1
    _secondsCountDown = 10;
    _secondsCountDown--;
    // _secondsCountDown = _secondsCountDown--;
    
    //修改倒计时显示时标签要实现的内容
    _getBtn.titleLabel.text = [NSString stringWithFormat:@"%ld验证码会在60s之内发送给你",_secondsCountDown];
    [_getBtn setTitle:_getBtn.titleLabel.text forState:UIControlStateNormal];
    _getBtn.titleLabel.lineBreakMode =NSLineBreakByWordWrapping;
    _getBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    if (_secondsCountDown == 0) {
        [_countDownTimer invalidate];
        
        
    }
}
-(void)clicknext:(UIButton *)sender{
    
    LX_enroll2ViewController *enroll2 = [LX_enroll2ViewController new];
    self.hidesBottomBarWhenPushed = YES;
    enroll2.view.backgroundColor =[UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
    [self.navigationController pushViewController:enroll2 animated:YES];
}
@end
