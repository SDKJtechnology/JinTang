//
//  LX_enroll2ViewController.m
//  金堂
//
//  Created by zouxin on 16/4/15.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "LX_enroll2ViewController.h"
#import <Masonry.h>
//#import "enrollViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/Extend/SMSSDK+AddressBookMethods.h>
#import <SMS_SDK/Extend/SMSSDK+DeprecatedMethods.h>
#import <SMS_SDK/Extend/SMSSDK+ExtexdMethods.h>
#import <AFNetworking.h>
@interface LX_enroll2ViewController ()<UITableViewDelegate,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UIButton *backBtn;
//@property(nonatomic,strong)UIBarButtonItem *rightItem;
@property(nonatomic,strong)UIView *backgroundView;

@property(nonatomic,strong)UITextField *textField1;

@property(nonatomic,strong)UITextField *textField2;

@property(nonatomic,strong)UITextField *textField3;
@property(nonatomic,strong)UILabel *labelone;

@property(nonatomic,strong)UIButton *btnGirl;
@property(nonatomic,strong)UIButton *btnBoy;


@property(nonatomic,strong)UILabel *labelGirl;
@property(nonatomic,strong)UILabel *labelBoy;

@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *btn;

@property(nonatomic,strong)UIButton *registerBtn;
@property(nonatomic,strong)UIButton *btntupian;

@end

@implementation LX_enroll2ViewController

-(UIView *)backgroundView{
    if (_backgroundView ==nil) {
        _backgroundView = [[UIView alloc]init];
        _backgroundView.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
        [self.view addSubview:_backgroundView];
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
    }
    return _backgroundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
     self.backgroundView.hidden = NO;
    self.navigationItem.title = @"注册";
    
    [[UINavigationBar appearance]setBarTintColor:[UIColor redColor]];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _backBtn.frame = CGRectMake(20, 30, 25, 25);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_nor"] forState:UIControlStateNormal];
    _backBtn.contentMode = UIViewContentModeScaleAspectFill;
    [_backBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_backBtn];
    
    
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height/8, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    

    
    
    _btntupian = [UIButton buttonWithType:UIButtonTypeCustom];
    _btntupian.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tupian-5"]];
  [_btntupian addTarget:self action:@selector(clicktuPian:) forControlEvents:UIControlEventTouchUpInside];
    [tableView addSubview:_btntupian];
    [_btntupian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tableView).offset(10);
        make.centerY.mas_equalTo(tableView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    
    
    _label = [[UILabel alloc]init];
    _label.text = @"我已阅读并同意";
    _label.textColor = [UIColor grayColor];
    
    _label.textAlignment = UITextAlignmentCenter;
    _label.lineBreakMode = UILineBreakModeWordWrap;
    _label.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    _label.numberOfLines = 1;
    [_label sizeToFit];
    _label.adjustsFontSizeToFitWidth = YES;
    [tableView addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_btntupian.mas_centerY);
        make.left.mas_equalTo(_btntupian.mas_right).offset(10);
    }];
    //创建立即注册的那个按钮，注册时也提交用户信息
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerBtn.backgroundColor = [UIColor grayColor];
    _registerBtn.userInteractionEnabled = NO;
    [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(submitUserInfo:) forControlEvents:UIControlEventTouchUpInside];
    [tableView addSubview:_registerBtn];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(tableView.mas_centerX);
        make.top.mas_equalTo(_label.mas_bottom).offset(10);
        make.width.mas_equalTo(tableView.mas_width).multipliedBy(0.8);
    }];
  
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.backgroundColor = [UIColor clearColor];
   
    [_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_btn setTitle:@"西昌之家网络服务条款" forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [tableView addSubview:_btn];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_label.mas_centerY);
        make.left.mas_equalTo(_label.mas_right).offset(10);
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1; //3个分区，默认是1
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
//每一行显示什么样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    //cell.textLabel.text = @"你好";
    cell.backgroundColor = [UIColor blueColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row ==0) {
        
        UIImage *image = [UIImage imageNamed:@"dongtai"];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [cell.contentView addSubview:imageView];
        cell.backgroundColor = [UIColor whiteColor];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView.mas_left).offset(10);
            make.centerY.mas_equalTo(cell.contentView.mas_centerY);
        }];
        
        
        _textField1 = [[UITextField alloc]init];
        _textField1.backgroundColor = [UIColor clearColor];
        _textField1.placeholder = @"用户名";
        _textField1.textAlignment = UITextAlignmentCenter;
       // _textField1.textAlignment = UITextAlignmentLeft;
        _textField1.borderStyle = UITextBorderStyleRoundedRect;
        
        _textField1.font = [UIFont systemFontOfSize:18];
        _textField1.adjustsFontSizeToFitWidth = YES;
        _textField1.keyboardType = UIKeyboardTypeDefault;
        _textField1.returnKeyType = UIReturnKeyDone;
        _textField1.delegate = self;
        
        
        [cell.contentView addSubview:_textField1];
        
        [_textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(cell.contentView.mas_height);
            make.width.mas_equalTo(cell.contentView.mas_width);
            
        }];
    }else if (indexPath.row ==1){
        
        UIImage *image = [UIImage imageNamed:@"suo"];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [cell.contentView addSubview:imageView];
        cell.backgroundColor = [UIColor whiteColor];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView.mas_left).offset(10);
            make.centerY.mas_equalTo(cell.contentView.mas_centerY);
        }];
        
        
        _textField2 = [[UITextField alloc]init];
        _textField2.backgroundColor = [UIColor clearColor];
        _textField2.placeholder = @"密码[至少6位，含字母和数字]";
        _textField2.textAlignment = NSTextAlignmentCenter;
        _textField2.secureTextEntry = YES;
        _textField2.borderStyle = UITextBorderStyleRoundedRect;
        
        _textField2.font = [UIFont systemFontOfSize:18];
        _textField2.adjustsFontSizeToFitWidth = YES;
        _textField2.keyboardType = UIKeyboardTypeNamePhonePad;
        _textField2.returnKeyType = UIReturnKeyDone;
         _textField2.delegate = self;
        
        
        [cell.contentView addSubview:_textField2];
        
        [_textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(cell.contentView.mas_height);
            make.width.mas_equalTo(cell.contentView.mas_width);
            
        }];
        
        
    }else if (indexPath.row == 2){
        
        UIImage *image = [UIImage imageNamed:@"suo"];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [cell.contentView addSubview:imageView];
        cell.backgroundColor = [UIColor whiteColor];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView.mas_left).offset(10);
            make.centerY.mas_equalTo(cell.contentView.mas_centerY);
        }];
        
        _textField3 = [[UITextField alloc]init];
        _textField3.backgroundColor = [UIColor clearColor];
        _textField3.placeholder = @"确认密码";
        _textField3.textAlignment = NSTextAlignmentCenter;
        
        _textField3.borderStyle = UITextBorderStyleRoundedRect;
        
        _textField3.font = [UIFont systemFontOfSize:20];
        _textField3.adjustsFontSizeToFitWidth = YES;
        _textField3.keyboardType = UIKeyboardTypeNamePhonePad;
        _textField3.returnKeyType = UIReturnKeyDone;
        _textField3.delegate = self;
        _textField3.secureTextEntry = YES;
        
        
        [cell.contentView addSubview:_textField3];
        
        [_textField3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(cell.contentView.mas_height);
            make.width.mas_equalTo(cell.contentView.mas_width);
            
        }];
        
    }else if (indexPath.row ==3){
        
        cell.backgroundColor = [UIColor whiteColor];
        
        UIImage *image = [UIImage imageNamed:@"tupian-6"];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [cell.contentView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView.mas_left).offset(10);
            make.centerY.mas_equalTo(cell.contentView.mas_centerY);
        }];
        
        //创建姓别的那个labelone
        _labelone = [[UILabel alloc]init];
        _labelone.text = @"姓别:";
        _labelone.textColor = [UIColor blackColor];
        _labelone.backgroundColor = [UIColor clearColor];
        _labelone.textAlignment = NSTextAlignmentCenter;
        _labelone.lineBreakMode = NSLineBreakByWordWrapping;
        _labelone.font = [UIFont fontWithName:@"AppleGothic" size:25];
        _labelone.numberOfLines = 1;
        [_labelone sizeToFit];
        _labelone.adjustsFontSizeToFitWidth = YES;
        _labelone.userInteractionEnabled = YES;
        [cell.contentView addSubview:_labelone];
        [_labelone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            make.left.mas_equalTo(imageView.mas_right).offset(10);
        }];
        
        _btnGirl = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnGirl setBackgroundImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
        [_btnGirl addTarget:self action:@selector(clicksex:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:_btnGirl];
        _btnGirl.tag = 2;
        [_btnGirl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            make.centerX.mas_equalTo(cell.contentView.mas_centerX).multipliedBy(0.8);
        }];
        //创建label"女"
        
        _labelGirl = [[UILabel alloc]init];
        _labelGirl.text = @"女";
        _labelGirl.textColor = [UIColor blackColor];
        _labelGirl.backgroundColor = [UIColor clearColor];
        _labelGirl.textAlignment = NSTextAlignmentCenter;
        _labelGirl.lineBreakMode = NSLineBreakByWordWrapping;
        _labelGirl.font = [UIFont fontWithName:@"AppleGothic" size:25];
        _labelGirl.numberOfLines = 1;
        [_labelGirl sizeToFit];
        _labelGirl.adjustsFontSizeToFitWidth = YES;
        _labelGirl.userInteractionEnabled = YES;
        [cell.contentView addSubview:_labelGirl];
        [_labelGirl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_btnGirl.mas_right).offset(10);
            make.centerY.mas_equalTo(cell.contentView.mas_centerY);
        }];
        
       
        _btnBoy = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnBoy setBackgroundImage:[UIImage imageNamed:@"tupian-5"] forState:UIControlStateNormal];
        _btnBoy.tag = 1;
        [_btnBoy addTarget:self action:@selector(clicksex:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:_btnBoy];
        [_btnBoy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            make.centerX.mas_equalTo(cell.contentView.mas_centerX).multipliedBy(1.4);
        }];
        
        //创建男士的那个男的label;
        _labelBoy = [[UILabel alloc]init];
        _labelBoy.text = @"男";
        _labelBoy.textColor = [UIColor blackColor];
        _labelBoy.backgroundColor = [UIColor whiteColor];
        _labelBoy.textAlignment = NSTextAlignmentCenter;
        _labelBoy.lineBreakMode = NSLineBreakByWordWrapping;
        _labelBoy.font = [UIFont fontWithName:@"AppleGothic" size:25];
        _labelBoy.numberOfLines = 1;
        [_labelBoy sizeToFit];
        _labelBoy.adjustsFontSizeToFitWidth = YES;
        _labelBoy.userInteractionEnabled = YES;
        [cell.contentView addSubview:_labelBoy];
        [_labelBoy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            make.left.mas_equalTo(_btnBoy.mas_right).offset(10);
        }];
        
    }
    return cell;
}

-(void)clicktuPian:(UIButton *)sender{
    NSLog(@"你点击了可以阅读的那张图片了");
[_btntupian setBackgroundImage:[UIImage imageNamed:@"gou"] forState:UIControlStateNormal];
    
    _registerBtn.backgroundColor = [UIColor colorWithRed:89/255.0 green:176.0/255 blue:245.0/255 alpha:1];
    _registerBtn.userInteractionEnabled = YES;

    
}
-(void)clicksex:(id)sender{
    NSLog(@"点了男女性别都可以从这里输出来");
    
    switch ([sender tag]) {
        case 2:
            NSLog(@"你点击的那个是女生的图标");
            [_btnGirl setBackgroundImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
            [_btnBoy setBackgroundImage:[UIImage imageNamed:@"tupian-5"] forState:UIControlStateNormal];
            break;
        case 1:
            NSLog(@"你点的那个是男生的图标");
            
            [_btnBoy setBackgroundImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
            [_btnGirl setBackgroundImage:[UIImage imageNamed:@"tupian-5"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

-(void)submitUserInfo:(UIButton *)sender{
    NSLog(@"点击了这个按钮你就可以提交信息了");
    
    //NSInteger value = [sender tag];
    
     NSString *urlString = @"http://192.168.0.110/Register/do_regsiter";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    //可变请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:2.0f];
    //指定http的访问方法，服务器端才知道我们是如何访问的
    //request.HTTPMethod = @"POST";
    //指定一个数据体，指定数据体的内容,数据体的内容可以从firebug里面直接拷贝过来

    NSString *code = _textField1.text;
    NSString *pwd = _textField2.text;
   // NSInteger value = [sender tag];
    NSString *bodyStr = [NSString stringWithFormat:@"code=%@pwd=%@",code,pwd];
    //,(long)[sender tag]
    
    NSData *data = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPMethod = @"POST";
    
    [request setHTTPBody:data];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //反序列化
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"返回的值是%@",json);
        [self loginView:json];
    }];
}
-(void)loginView:(NSDictionary *)params{
    NSLog(@"1234");
    NSDictionary *codeDic = params[@"msg"];
    NSLog(@"msg注册的值是:%@",codeDic);
    
    int value =[params[@"code"]floatValue];
    NSLog(@"%d",value);
    if (value ==-4) {
        NSLog(@"请输入账号");
        
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入账号" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertViewController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertViewController animated:YES completion:nil];
    }else if (value ==-5){
        NSLog(@"请输入密码");
        
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入密码" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertViewController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertViewController animated:YES completion:nil];
        
        
    }else if (value ==-6){
        NSLog(@"请输入性别");
        
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择性别" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertViewController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertViewController animated:YES completion:nil];
        
    }else if (value ==-3){
        NSLog(@"手机号码已经存在");
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号码已经存在" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertViewController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertViewController animated:YES completion:nil];
    }else if (value ==-2){
        NSLog(@"注册失败");
        
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册失败" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertViewController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertViewController animated:YES completion:nil];
    }else if (value ==-1){
        NSLog(@"账号已经存在");
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号已经存在" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertViewController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertViewController animated:YES completion:nil];
        
    }else if (value ==0){
        NSLog(@"注册成功");
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField1 resignFirstResponder];
    [_textField2 resignFirstResponder];
    [_textField3 resignFirstResponder];
    return YES;
}
-(void)click:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.height/10;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textField1 resignFirstResponder];
    [self.view endEditing:YES];
}


@end
