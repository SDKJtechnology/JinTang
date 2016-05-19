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
#import "TJ_EmojiView.h"
#import "TJ_ImagePickerView.h"

@interface TJ_CommunityReleaseController ()<UITextViewDelegate,TJ_EmojiViewDelegate>
{
    CGRect keyboardFrame;//键盘的frame
    
    BOOL isKeyboardShowd;//键盘是否已经显示
    
    UITextView *currentTextView;//当前textView，默认为titleTextView
}
/**
 *  发布按钮
 */
@property (nonatomic, strong) UIButton *releaseButton;
/**
 *  标题编辑视图
 */
@property (nonatomic, strong) BCTextView *titleTextView;
/**
 *  内容编辑视图
 */
@property (nonatomic, strong) BCTextView *contentTextView;
/**
 *  表情选项按钮
 */
@property (nonatomic, strong) UIButton *emojiButton;
/**
 *  照片选项按钮
 */
@property (nonatomic, strong) UIButton *photoButton;

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
    
    _releaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _releaseButton.adjustsImageWhenHighlighted = NO;
    [_releaseButton setTitle:@"发布" forState:UIControlStateNormal];
    _releaseButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [_releaseButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _releaseButton.frame = CGRectMake(self.view.width - 44, 27, 40, 30);
    [self.view addSubview:_releaseButton];
    _releaseButton.layer.masksToBounds = YES;
    _releaseButton.layer.borderColor = [[UIColor grayColor] CGColor];
    _releaseButton.layer.borderWidth = 0.5f;
    _releaseButton.layer.cornerRadius = 3;
    
    [_releaseButton addTarget:self action:@selector(didClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_photoButton];
    _photoButton.adjustsImageWhenHighlighted = NO;
    _photoButton.sd_layout
    .leftSpaceToView(self.view, 10)
    .bottomSpaceToView(self.view, 15)
    .widthIs(30)
    .heightIs(30);
//    _photoButton.backgroundColor = [UIColor redColor];
    [_photoButton addTarget:self action:@selector(didClickPhotoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_photoButton setImage:[[UIImage imageNamed:@"actionbar_picture_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    _emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_emojiButton];
    _emojiButton.adjustsImageWhenHighlighted = NO;
    _emojiButton.sd_layout
    .leftSpaceToView(_photoButton, 10)
    .bottomSpaceToView(self.view, 15)
    .heightRatioToView(_photoButton, 1)
    .widthRatioToView(_photoButton, 1);
    [_emojiButton addTarget:self action:@selector(didClickEmojiButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_emojiButton setImage:[[UIImage imageNamed:@"chatting_biaoqing_btn_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_emojiButton setImage:[[UIImage imageNamed:@"chat_setmode_key_btn_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
//    _emojiButton.backgroundColor = [UIColor blueColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyBoardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyBoardNotification:) name:UIKeyboardWillHideNotification object:nil];
    
    [_titleTextView becomeFirstResponder];
}

#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    currentTextView = textView;
    if (self.emojiButton.selected) {
        self.emojiButton.selected = NO;
    }
    textView.inputView = nil;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (![_contentTextView.text isEqualToString:@""] && ![_titleTextView.text isEqualToString:@""])
    {
        _releaseButton.backgroundColor = [UIColor blueColor];
        [_releaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else{
        [_releaseButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _releaseButton.backgroundColor = self.view.backgroundColor;
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
        [self didClickRightButton:_releaseButton];
        return NO;
    }
    
    return YES;
}

#pragma mark TJ_EmojiViewDelegate
- (void)didSelectedEmojiImagePath:(NSString *)emojiImagePath isDelete:(BOOL)deleted
{
    if ([currentTextView.text isEqualToString:@""]) {
        currentTextView.text = @"";
    }
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:currentTextView.attributedText];
    
    if (deleted) {
        if (text.length){
            [text deleteCharactersInRange:NSMakeRange(text.length - 1, 1)];
            //            NSLog(@"asdfasfsadf%ld",text.length);
            currentTextView.attributedText = text;
        }
        if (!text.length){
            currentTextView.text = @"";
        }
    }else{
        UIImage *image = [UIImage imageNamed:emojiImagePath];
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = image;
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attachment];
        [text appendAttributedString:string];
        currentTextView.attributedText = text;
    }
}

#pragma mark Actions

- (void)didClickPhotoButtonAction
{
    isKeyboardShowd = YES;
    [currentTextView resignFirstResponder];
    
    TJ_ImagePickerView *view = [[TJ_ImagePickerView alloc] initWithFrame:keyboardFrame];
    currentTextView.inputView = view;
    
    [currentTextView becomeFirstResponder];
}

- (void)didClickEmojiButtonAction
{
    self.emojiButton.selected = !self.emojiButton.selected;
    
    isKeyboardShowd = YES;
    [currentTextView resignFirstResponder];
    if (self.emojiButton.selected) {
        TJ_EmojiView *view = [[TJ_EmojiView alloc] initWithFrame:keyboardFrame];
        view.delegateEmojiView = self;
        currentTextView.inputView = view;
    }
    else{
        currentTextView.inputView = nil;
    }
    
    [currentTextView becomeFirstResponder];
}

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

#pragma mark Others
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
    
    [self updateSubviewsBigingEditing:YES];
}

//键盘将要回收
- (void)willHideKeyBoardNotification:(NSNotification *)notification
{
    NSLog(@"");
    if (!isKeyboardShowd){
        CGRect frame = _contentTextView.frame;
        frame.size.height = self.view.height - _titleTextView.bottom;
        _contentTextView.frame = frame;
        
        [self updateSubviewsBigingEditing:NO];
    }
    isKeyboardShowd = NO;
}

//根据编辑状态改变控件frame
- (void)updateSubviewsBigingEditing:(BOOL)editing
{
    CGFloat keyBoardH = keyboardFrame.size.height;
    if (editing){
        _photoButton.sd_layout.bottomSpaceToView(self.view, keyBoardH + 10);
        _emojiButton.sd_layout.bottomSpaceToView(self.view, keyBoardH + 10);
    }else{
        _photoButton.sd_layout.bottomSpaceToView(self.view, 10);
        _emojiButton.sd_layout.bottomSpaceToView(self.view, 10);
    }
}

@end
