
//
//  TJ_DetailsViewController.m
//  金堂
//
//  Created by SDKJ on 16/4/28.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_DetailsBaseViewController.h"
#import "SDAutoLayout.h"

@interface TJ_DetailsBaseViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *supportButton;

@end

@implementation TJ_DetailsBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setup];

}

- (void)setup
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.width, 44)];
    [self.view addSubview:titleLabel];
    titleLabel.backgroundColor = [UIColor colorWithWhite:0.920 alpha:1.000];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = self.titelString;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftButton setTitle:@"<" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 20, 44, 44);
    [self.view addSubview:leftButton];
    [leftButton addTarget:self action:@selector(didClickLeftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    _rightButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusCenter];
    [_rightButton setTitle:@"● ● ●" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _rightButton.frame = CGRectMake(self.view.width - 44, 20, 44, 44);
    [self.view addSubview:_rightButton];
    
    [_rightButton addTarget:self action:@selector(didClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _bottomView = [[UIView alloc] init];
    _bottomView.layer.borderColor = [[UIColor grayColor] CGColor];
    _bottomView.layer.borderWidth = 1;
    [self.view addSubview:_bottomView];
    _bottomView.sd_layout
    .leftSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(49);
    [_bottomView updateLayout];
    _bottomView.fixedHeight = @49;
    
    _supportButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_bottomView addSubview:_supportButton];
    _supportButton.sd_layout
    .topSpaceToView(_bottomView, 10)
    .leftSpaceToView(_bottomView, 10)
    .bottomSpaceToView(_bottomView, 10)
    .heightEqualToWidth();
    _supportButton.sd_cornerRadiusFromWidthRatio = @0.5;
    _supportButton.backgroundColor = [UIColor yellowColor];
    
    _rightLabel= [[UILabel alloc] init];
    [_bottomView addSubview:_rightLabel];
    _rightLabel.sd_layout
    .topSpaceToView(_bottomView, 0)
    .rightSpaceToView(_bottomView, 15)
    .heightRatioToView(_bottomView, 1);
    [_rightLabel setSingleLineAutoResizeWithMaxWidth:self.view.width / 2];
    _rightLabel.font = [UIFont fontWithName:TJFont size:15];
    _rightLabel.textColor = [UIColor colorWithWhite:0.673 alpha:1.000];
    _rightLabel.text = @"洛杉矶的风景";
    
    _textField = [[UITextField alloc] init];
    [_bottomView addSubview:_textField];
    _textField.sd_layout
    .topSpaceToView(_bottomView, 5)
    .leftSpaceToView(_supportButton, 10)
    .rightSpaceToView(_supportButton, 10)
    .bottomSpaceToView(_bottomView, 5);
    _textField.layer.borderColor = [[UIColor grayColor] CGColor];
    _textField.layer.borderWidth = 0.5;
    _textField.layer.cornerRadius = 5;
    _textField.placeholder = @" 回复楼主";
    _textField.delegate = self;
    [_textField setValue:_rightLabel.textColor forKeyPath:@"_placeholderLabel.textColor"];
    [_textField setValue:_rightLabel.font forKeyPath:@"_placeholderLabel.font"];

}

#pragma mark UITextFieldDelegate

//已经开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _textField.placeholder = @" 我来说一句...";
    _rightLabel.hidden = YES;
}
//已经结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _textField.placeholder = @" 回复楼主";
    _rightLabel.hidden = NO;
}

// 点击键盘上Return按钮时候调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    
    _textField.text = @"";
    _textField.placeholder = @" 回复楼主";
    _rightLabel.hidden = NO;
    
    return YES;
}

#pragma mark Actions

- (void)didClickRightButton:(TJ_BACustomButton *)sender
{}

- (void)didClickLeftButtonAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
