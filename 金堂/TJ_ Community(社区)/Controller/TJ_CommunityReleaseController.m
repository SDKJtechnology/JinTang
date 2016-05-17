//
//  TJ_CommunityReleaseController.m
//  金堂
//
//  Created by SDKJ on 16/5/17.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_CommunityReleaseController.h"
#import "SDAutoLayout.h"
#import "BCTextView.h"

@interface TJ_CommunityReleaseController ()<UITextViewDelegate>
{
    CGRect keyboardFrame;
    BOOL isKeyboardShowd;
}

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) BCTextView *titleTextView;

@property (nonatomic, strong) BCTextView *contentTextView;

@end

@implementation TJ_CommunityReleaseController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithWhite:0.738 alpha:1.000];
    
    UIView *starView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    starView.backgroundColor = [UIColor colorWithWhite:0.964 alpha:1.000];
    [self.view addSubview:starView];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftButton setTitle:@"<" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 20, 44, 44);
    [self.view addSubview:leftButton];
    [leftButton addTarget:self action:@selector(didClickLeftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setTitle:@"发布" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [_rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _rightButton.frame = CGRectMake(self.view.width - 44, 27, 40, 30);
    [self.view addSubview:_rightButton];
    _rightButton.layer.masksToBounds = YES;
    _rightButton.layer.borderColor = [[UIColor grayColor] CGColor];
    _rightButton.layer.borderWidth = 0.5f;
    _rightButton.layer.cornerRadius = 3;
    
    [_rightButton addTarget:self action:@selector(didClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleTextView = [BCTextView new];
    [self.view addSubview:_titleTextView];
    _titleTextView.sd_layout
    .topSpaceToView(leftButton, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(40);
    _titleTextView.placeholder = @"标题（必填）";
    _titleTextView.font = [UIFont fontWithName:TJFont size:22];
    _titleTextView.delegate = self;
    
    [_titleTextView updateLayout];
    _contentTextView = [BCTextView new];
    [self.view addSubview:_contentTextView];
    _contentTextView.sd_layout
    .yIs(_titleTextView.bottom)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(self.view.height - _titleTextView.bottom);
    _contentTextView.placeholder = @"正文（必填）";
    _contentTextView.text = @"";
    _contentTextView.font = [UIFont fontWithName:TJFont size:15];
    _contentTextView.textColor = [UIColor grayColor];
    _contentTextView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyBoardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyBoardNotification:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (![_contentTextView.text isEqualToString:@""] && ![_titleTextView.text isEqualToString:@""])
    {
        _rightButton.backgroundColor = [UIColor blueColor];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else{
        [_rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _rightButton.backgroundColor = self.view.backgroundColor;
    }
}

// 点击键盘上Return按钮时候调用
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
        NSLog(@"%@",textView.text);
    
    if (![_contentTextView.text isEqualToString:@""] && ![_titleTextView.text isEqualToString:@""]){
        
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
        }
        
        return YES;
    }
    if ([text isEqualToString:@"\n"]) {
        [self didClickRightButton:_rightButton];
        return NO;
    }
    
    return YES;
}

#pragma mark Actions

- (void)didClickLeftButtonAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didClickRightButton:(UIButton *)sender
{
    NSLog(@"发布");
    if ([_titleTextView.text isEqualToString:@""]) {
        [self addPromptViewText:@"标题内容不能为空"];
    }
    else if ([_contentTextView.text isEqualToString:@""]){
        [self addPromptViewText:@"内容不能为空"];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//添加提示视图
- (void)addPromptViewText:(NSString *)text
{
    UILabel *promptLabel = [UILabel new];
    [[UIApplication sharedApplication].windows.lastObject addSubview:promptLabel];
    promptLabel.text = text;
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.sd_layout.widthIs(150).heightIs(30);
    CGPoint center = self.view.center;
    promptLabel.center = CGPointMake(center.x, center.y * 1.8);
    promptLabel.sd_cornerRadiusFromHeightRatio = @0.5;
    promptLabel.textColor = [UIColor whiteColor];
    promptLabel.font = [UIFont fontWithName:TJFont size:15];
    promptLabel.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.7];
    
    [UIView animateWithDuration:3 animations:^{
        promptLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [promptLabel removeFromSuperview];
    }];
}

//键盘将要显示
- (void)willShowKeyBoardNotification:(NSNotification *)notification
{
    //    NSLog(@"%@",notification.userInfo);
    keyboardFrame = [[notification.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    if ([_contentTextView.text isEqualToString:@""]) {
        _contentTextView.text = @"";
    }
    
    CGRect frame = _contentTextView.frame;
    frame.size.height = keyboardFrame.origin.y - _titleTextView.bottom;
    _contentTextView.frame = frame;
}

//键盘将要回收
- (void)willHideKeyBoardNotification:(NSNotification *)notification
{
    CGRect frame = _contentTextView.frame;
    frame.size.height = self.view.height - _titleTextView.bottom;
    _contentTextView.frame = frame;
}

@end
