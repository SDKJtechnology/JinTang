//
//  LX_MendViewController.m
//  金堂
//
//  Created by zouxin on 16/4/22.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "LX_MendViewController.h"
#import <Masonry.h>
#import "LX_foundViewController.h"
#import "UMSocial.h"

#define kUMKey    @"5657f8a367e58e3b660032d7"


@interface LX_MendViewController ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UITextField *textFieldAccount;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)UIButton *btn;

@end

@implementation LX_MendViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"erweima"] style:UIBarButtonItemStylePlain target:self action:@selector(clickQRCode:)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 6, 67, 23);
    
    UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigator_btn_back"]];
    
    backImg.frame = CGRectMake(-10, 0, 22, 22);
    [backBtn addSubview:backImg];
    
    UILabel *backText = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 65, 22)];
    backText.text = @"返回";
    backText.font = [UIFont systemFontOfSize:15];
    [backText setBackgroundColor:[UIColor clearColor]];
    [backText setTextColor:[UIColor whiteColor]];
    [backBtn addSubview:backText];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    //创建头象
     UIImage *image = [UIImage imageNamed:@"头像.png"];
    _imageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).multipliedBy(0.5);
    }];
    //创建用户名的那个label
    _label = [[UILabel alloc]init];
    _label.text = @"Ta123";
    _label.backgroundColor = [UIColor redColor];
    _label.textColor = [UIColor blackColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.font = [UIFont fontWithName:@"AmericanTypewriter" size:25];
    _label.numberOfLines = 1;
    [_label sizeToFit];
    _label.adjustsFontSizeToFitWidth = YES;
   
    [self.view addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_imageView.mas_bottom).offset(10);
    }];
    //创建输入框的那个背景图
    UIImage *image2 = [UIImage imageNamed:@"tupianlast"];
    UIImageView *imageView2 = [[UIImageView alloc]initWithImage:image2];
    [self.view addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    //创建用户名的那个textfield
    _textFieldAccount = [[UITextField alloc]init];
    
    _textFieldAccount.backgroundColor = [UIColor clearColor];
    _textFieldAccount.placeholder = @"请输入用户名/手机号";
    _textFieldAccount.textAlignment = NSTextAlignmentCenter;
    _textFieldAccount.borderStyle = UITextBorderStyleRoundedRect;
    _textFieldAccount.font = [UIFont systemFontOfSize:18];
    _textFieldAccount.adjustsFontSizeToFitWidth = YES;
    _textFieldAccount.keyboardType = UIKeyboardTypeNamePhonePad;
    _textFieldAccount.returnKeyType = UIReturnKeyDone;//设置键盘的完成按钮
    // _textFieldAccount.delegate = self;
    
    [self.view addSubview:_textFieldAccount];
    [_textFieldAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView2.mas_centerX);
        make.width.mas_equalTo(imageView2.mas_width);
        // make.left.mas_equalTo(_label2.mas_right);
        make.right.mas_equalTo(imageView2.mas_right);
        make.centerY.mas_equalTo(imageView2.mas_centerY);
        make.height.mas_equalTo(imageView2.mas_height);
    }];
    
        //创建左边写有用户名的那个label
    _label2 = [[UILabel alloc]init];
    _label2.text = @"用户名";
    _label2.backgroundColor = [UIColor whiteColor];
    _label2.textColor = [UIColor grayColor];
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.lineBreakMode = NSLineBreakByWordWrapping;
    _label2.font = [UIFont fontWithName:@"AmericanTypewriter" size:18];
    _label2.numberOfLines = 1;
    [_label2 sizeToFit];
    _label2.adjustsFontSizeToFitWidth = YES;
    
    [self.view addSubview:_label2];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView2.mas_left);
        make.centerY.mas_equalTo(imageView2.mas_centerY);
    }];
    //创建提交的那个按钮
    _btn = [[UIButton alloc]init];
    _btn.backgroundColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tijiao"]];
    
    [self.view addSubview:_btn];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(imageView2.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(111, 25));
    }];
}
-(void)clickBack:(UIButton *)sender{
    LX_foundViewController *foundViewController = [LX_foundViewController new];

    [self.navigationController pushViewController:foundViewController animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)isDirectShareInIconActionSheet{
    return YES;
}

//下面都是做的分享功能的弹框的功能
-(void)clickQRCode:(UIBarButtonItem *)sender{
    NSLog(@"其实你点击的是分享功能");

    
    DownSheet *sheet = [[DownSheet alloc]initWithlist:MenuList height:0];
    
    sheet.delegate = self;
    [sheet showInView:nil];

}
-(void)didSelectIndex:(NSInteger)index{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"您当前点击的是第%d个按钮",index] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}


@end
