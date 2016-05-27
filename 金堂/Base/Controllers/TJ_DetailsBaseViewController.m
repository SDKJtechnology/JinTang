
//
//  TJ_DetailsViewController.m
//  金堂
//
//  Created by SDKJ on 16/4/28.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_DetailsBaseViewController.h"
#import "SDAutoLayout.h"
#import "BCTextView.h"
#import "TJ_EmojiView.h"
#import "TJ_ImagePickerView.h"

//将数字转为
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);

@interface TJ_DetailsBaseViewController ()<UITextViewDelegate,TJ_EmojiViewDelegate>
{
    UITapGestureRecognizer *tapGestureRecognizer;
    
    CGRect keyboardFrame;
    
    UIView *currentInputView;
    
    NSAttributedString *_didEditingText;
    
    BOOL isShowInputView;
}
//@property (nonatomic, strong) NSAttributedString *didEditingText;

@property (nonatomic, strong) BCTextView *textView;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *supportButton;

@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, strong) UIButton *photoButton;

@property (nonatomic, strong) UIButton *emojiButton;

@property (nonatomic, strong) TJ_EmojiView *emojiView;

@property (nonatomic, strong) TJ_ImagePickerView *imagePickerView;

@end

@implementation TJ_DetailsBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    currentInputView = nil;
    _didEditingText = nil;
    
    [self setup];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyBoardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyBoardNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _textView.attributedText = _didEditingText;
    [self showInputView:currentInputView];
}

- (void)didReceiveMemoryWarning
{
    [self didReceiveMemoryWarning];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 添加设置子视图

- (void)setup
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.width, 44)];
    [self.view addSubview:titleLabel];
    titleLabel.backgroundColor = [UIColor colorWithWhite:0.920 alpha:1.000];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = self.titelString;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftButton setImage:[[UIImage imageNamed:@"xiaoyufu_02"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(10, 32, 20, 20);
    [self.view addSubview:leftButton];
    [leftButton addTarget:self action:@selector(didClickLeftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    _rightButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusCenter];
    [_rightButton setTitle:@"● ● ●" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _rightButton.frame = CGRectMake(self.view.width - 44, 20, 44, 44);
    [self.view addSubview:_rightButton];
    
    [_rightButton addTarget:self action:@selector(didClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _bottomView = [[UIView alloc] init];
    _bottomView.layer.borderColor = [[UIColor grayColor] CGColor];
    _bottomView.layer.borderWidth = 1;
    _bottomView.backgroundColor = [UIColor colorWithWhite:0.857 alpha:1.000];
    _bottomView.hidden = !self.showBottomView;
    [self.view addSubview:_bottomView];
    _bottomView.sd_layout
    .leftSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(BottonView_H);
    [_bottomView updateLayout];
    
    _supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _supportButton.adjustsImageWhenHighlighted = NO;
    [_bottomView addSubview:_supportButton];
    _supportButton.sd_layout
    .topSpaceToView(_bottomView, 10)
    .leftSpaceToView(_bottomView, 10)
    .widthIs(BottonView_H - 20)
    .heightEqualToWidth();
    _supportButton.sd_cornerRadiusFromWidthRatio = @0.5;
//    _supportButton.backgroundColor = [UIColor yellowColor];
    _supportButton.layer.masksToBounds = YES;
    _supportButton.layer.borderColor = [UIColor grayColor].CGColor;
    _supportButton.layer.borderWidth = 1.0f;
    [_supportButton setImage:[[UIImage imageNamed:@"zan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    [_supportButton addTarget: self action:@selector(didCilckSupportButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    _rightLabel= [[UILabel alloc] init];
    [_bottomView addSubview:_rightLabel];
    _rightLabel.sd_layout
    .topSpaceToView(_bottomView, 0)
    .rightSpaceToView(_bottomView, 15)
    .heightRatioToView(_bottomView, 1);
    [_rightLabel setSingleLineAutoResizeWithMaxWidth:self.view.width / 2];
    _rightLabel.font = [UIFont fontWithName:TJFont size:13];
//    _rightLabel.textColor = [UIColor colorWithWhite:0.673 alpha:1.000];
    _rightLabel.text = @"已有0条回复";
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.adjustsImageWhenHighlighted = NO;
    [_bottomView addSubview:_sendButton];
    _sendButton.sd_layout
    .topEqualToView(_supportButton)
    .rightSpaceToView(_bottomView, 10)
    .bottomSpaceToView(_bottomView, 10)
    .widthIs(0);
    _sendButton.titleLabel.font = [UIFont fontWithName:TJFont size:15];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _sendButton.layer.masksToBounds = YES;
    _sendButton.layer.borderColor = [[UIColor grayColor] CGColor];
    _sendButton.layer.borderWidth = 0.5;
    _sendButton.layer.cornerRadius = 5;
    [_sendButton addTarget:self action:@selector(didClickSendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    _textView = [[BCTextView alloc] init];
    [_bottomView insertSubview:_textView atIndex:0];
    _textView.sd_layout
    .topSpaceToView(_bottomView, 5)
    .leftSpaceToView(_supportButton, 10)
    .rightSpaceToView(_sendButton, 0)
    .bottomSpaceToView(_bottomView, 5);
    _textView.layer.borderColor = _sendButton.layer.borderColor;
    _textView.layer.borderWidth = _sendButton.layer.borderWidth;
    _textView.layer.cornerRadius = 5;
    _textView.placeholder = @"回复楼主";
    _textView.font = _rightLabel.font;
    _textView.delegate = self;
    
    _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _photoButton.adjustsImageWhenHighlighted = NO;
    [_bottomView addSubview:_photoButton];
    _photoButton.sd_layout
    .leftEqualToView(_supportButton)
    .topSpaceToView(_bottomView, 5)
    .bottomSpaceToView(_bottomView, 5)
    .widthEqualToHeight();
    _photoButton.hidden = YES;
    [_photoButton addTarget:self action:@selector(didCilckPhotoButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    _photoButton.backgroundColor = [UIColor blueColor];
    [_photoButton setImage:[[UIImage imageNamed:@"tupian_01"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    _emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _emojiButton.adjustsImageWhenHighlighted = NO;
    [_bottomView addSubview:_emojiButton];
    _emojiButton.sd_layout
    .leftSpaceToView(_photoButton, 10)
    .topSpaceToView(_bottomView, 10)
    .bottomSpaceToView(_bottomView, 10)
    .widthEqualToHeight();
    _emojiButton.hidden = YES;
    _emojiButton.sd_cornerRadiusFromWidthRatio = @0.5;
    [_emojiButton addTarget:self action:@selector(didCilckEmojiButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    _emojiButton.backgroundColor = [UIColor redColor];
    [_emojiButton setImage:[[UIImage imageNamed:@"chatting_biaoqing_btn_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_emojiButton setImage:[[UIImage imageNamed:@"chat_setmode_key_btn_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
}

//获取默认表情数组
//- (NSArray *)defaultEmoticons {
//    NSMutableArray *array = [NSMutableArray new];
//    for (int i=0x1F600; i<=0x1F64F; i++) {
//        if (i < 0x1F641 || i > 0x1F644) {
//            int sym = EMOJI_CODE_TO_SYMBOL(i);
//            NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
//            [array addObject:emoT];
//        }
//    }
//    return array;
//}
#pragma mark seting
- (void)setShowBottomView:(BOOL)showBottomView
{
    _showBottomView = showBottomView;
    self.bottomView.hidden = !showBottomView;
}

#pragma mark UITextViewDelegate

//已经开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    if ([_textView.text isEqualToString:@""]) {
        _textView.placeholder = @"我来说一句...";
        _textView.text = @"";
    }
    
    _rightLabel.hidden = YES;
    
    [self updateSubviewsBigingEditing:YES];
    return YES;
}

// 点击键盘上Return按钮时候调用
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    NSLog(@"%@",textView.attributedText.string);
    if ([text isEqualToString:@"\n"]) {
        if (![_textView.text isEqualToString:@""])
        {
            [_textView resignFirstResponder];
        }
        else
        {
            [self addPromptView];
        }
        return NO;
    }
    return YES;
}

#pragma mark Tj_EmojiViewDelegate

- (void)didSelectedEmojiImagePath:(NSString *)emojiImagePath isDelete:(BOOL)deleted
{
    if ([_textView.text isEqualToString:@""]) {
        _textView.text = @"";
    }
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];
    
    if (deleted) {
        if (text.length){
            if (_textView.selectedRange.length) {
                [text deleteCharactersInRange:_textView.selectedRange];
            }
            else
            {
                [text deleteCharactersInRange:NSMakeRange(text.length - 1, 1)];
            }
            //            NSLog(@"asdfasfsadf%ld",text.length);
            _textView.attributedText = text;
        }
        if (!text.length){
            _textView.text = @"";
        }
    }else{
        UIImage *image = [UIImage imageNamed:emojiImagePath];
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = image;
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attachment];
        NSRange range = _textView.selectedRange;
        [text replaceCharactersInRange:range withAttributedString:string];
        _textView.attributedText = text;
        _textView.selectedRange = NSMakeRange(range.location + 1, 0);
    }
//    NSLog(@"%ld  %ld",_textView.selectedRange.location,_textView.selectedRange.length);
}

#pragma mark Actions
//点击右侧按钮（用于子类重写）
- (void)didClickRightButton:(TJ_BACustomButton *)sender
{}
//点击左侧按钮
- (void)didClickLeftButtonAction
{
    [_textView resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击点赞按钮
- (void)didCilckSupportButtonAction
{
    NSLog(@"点赞");
}

//点击图片按钮
- (void)didCilckPhotoButtonAction
{
    isShowInputView = YES;
    [_textView resignFirstResponder];
    if (!_imagePickerView) {
        _imagePickerView = [[TJ_ImagePickerView alloc] initWithFrame:keyboardFrame];
    }
    
    [self showInputView:_imagePickerView];
}

//点击表情按钮
- (void)didCilckEmojiButtonAction
{
    isShowInputView = YES;
    _emojiButton.selected = !_emojiButton.selected;
    [_textView resignFirstResponder];
    
    if (_emojiButton.selected) {
        _emojiView = [[TJ_EmojiView alloc] initWithFrame:keyboardFrame];
        _emojiView.delegateEmojiView = self;
        [self showInputView:_emojiView];
    }
    else{
        [self showInputView:nil];
    }
}

//点击发送按钮
- (void)didClickSendButtonAction
{
    if (![_textView.text isEqualToString:@""]) {
        NSLog(@"发送选择%ld:张图",_imagePickerView.selectedPhotos.count);

        _imagePickerView = nil;
        _didEditingText = nil;
        _textView.text = @"";
        [_textView resignFirstResponder];
    }
    else
    {
        [self addPromptView];
    }
}

#pragma mark Others
//显示制定的输入视图
- (void)showInputView:(UIView *)view
{
    _textView.inputView = view;
    [_textView becomeFirstResponder];
    currentInputView = view;
}

//添加提示视图
- (void)addPromptView
{
    UILabel *promptLabel = [UILabel new];
    [[UIApplication sharedApplication].windows.lastObject addSubview:promptLabel];
    promptLabel.text = @"内容不能为空!";
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
    _bottomView.origin =  CGPointMake(keyboardFrame.origin.x, keyboardFrame.origin.y - BottonView_H);
//    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(willHideKeyBoard)];
//    [[UIApplication sharedApplication].keyWindow addGestureRecognizer:tapGestureRecognizer];
}

//键盘即将移除
- (void)willHideKeyBoardNotification:(NSNotification *)notification
{
    _didEditingText = _textView.attributedText;

    if (!isShowInputView){
        keyboardFrame = [[notification.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
        _bottomView.origin =  CGPointMake(keyboardFrame.origin.x, keyboardFrame.origin.y - BottonView_H);
    
//    [self.view removeGestureRecognizer:tapGestureRecognizer];
    
        [self updateSubviewsBigingEditing:NO];
        _textView.inputView = nil;
    }
    isShowInputView = NO;
}


//根据编辑状态改变控件frame
- (void)updateSubviewsBigingEditing:(BOOL)editing
{
    if (editing){
        _supportButton.sd_layout.widthIs(0);
        _sendButton.sd_layout.widthIs(40);
        _photoButton.hidden = NO;
        _emojiButton.hidden = NO;
        _textView.sd_layout.rightSpaceToView(_sendButton, 10).leftSpaceToView(_emojiButton, 10);
    }else{
        _sendButton.sd_layout.widthIs(0);
        _supportButton.sd_layout.widthIs(BottonView_H - 20);
        _photoButton.hidden = YES;
        _emojiButton.hidden = YES;
        _emojiButton.selected = NO;
        _textView.sd_layout.rightSpaceToView(_sendButton, 0).leftSpaceToView(_supportButton, 10);
        
        _textView.attributedText = _didEditingText;
        _textView.placeholder = @"回复楼主";
        _rightLabel.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            _bottomView.origin =  CGPointMake(0, self.view.height - BottonView_H);
        } completion:nil];
    }
}

@end
