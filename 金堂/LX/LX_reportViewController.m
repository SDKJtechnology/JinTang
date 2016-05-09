//
//  LX_reportViewController.m
//  金堂
//
//  Created by zouxin on 16/5/4.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "LX_reportViewController.h"
#import <Masonry.h>
@interface LX_reportViewController ()<UITextViewDelegate,UITextViewDelegate>
{
    UITextView *textView;
    
}
@property(nonatomic,retain)UITextView *textView;

@property(nonatomic,strong)UIBarButtonItem *leftItem;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)UITableView *tableView;



@end

@implementation LX_reportViewController
-(UIBarButtonItem *)leftItem{
    if (!_leftItem) {
        _leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss:)];
        //让返回的字体颜色变成黑色
        _leftItem.tintColor = [UIColor blackColor];
        
    }
    return _leftItem;
}

//创建导航控制器的方法
-(void)dismiss:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    //textView中的字体颜色
    _textView.textColor = [UIColor grayColor];
    _textView.font = [UIFont  fontWithName:@"Arial" size:18.0];
    //_textView.text = @"填写你的举报原因";
    _textView.contentInset = UIEdgeInsetsMake(8.f, 0.f, -8.f, 0.f);
    
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor redColor];
    _textView.scrollEnabled = YES;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(64);
    }];
   
    _label2 = [[UILabel alloc]init];
    _label2.enabled = NO;
    _label2.text = @"在下面输入反馈意见";
    _label2.backgroundColor = [UIColor clearColor];
    _label2.font = [UIFont systemFontOfSize:15];
    _label2.textColor = [UIColor lightGrayColor];
    [_textView addSubview:_label2];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_textView.mas_top).offset(-60);        make.left.mas_equalTo(_textView.mas_left);
    }];
    UILabel *label= [[UILabel alloc]init];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    label.text = @"举报";
    
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = [UIFont fontWithName:@"AmericanTypewriter" size:18];
    label.numberOfLines = 1;
    
    [label sizeToFit];
    label.adjustsFontSizeToFitWidth = YES;
    label.userInteractionEnabled = YES;
    //self.navigationItem.title = label;
    self.navigationItem.titleView = label;
    self.navigationItem.leftBarButtonItem =self.leftItem;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text{
    if ([@"\n" isEqualToString:text] ==YES) {
        [textView resignFirstResponder];
     return NO;
    }
    return YES;
}
//-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    if (textView.tag ==0) {
//        textView.text = @"12344";
//        textView.textColor = [UIColor blackColor];
//        textView.tag = 1;
//    }
//    return YES;
//}
//-(void)textViewDidChange:(UITextView *)textView{
//    if ([textView.text length]==0) {
//        textView.text = @"我说123木头人";
//        textView.textColor = [UIColor lightGrayColor];
//        textView.tag = 0;
//    }
//}

@end
