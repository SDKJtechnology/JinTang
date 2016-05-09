//
//  DownSheet.m
//  audioWriting
//
//  Created by wolf on 14-7-19.
//  Copyright (c) 2014年 wangruiyy. All rights reserved.
//

#import "DownSheet.h"
#import <Masonry.h>
#import "AppDelegate.h"
#import <WeiboSDK.h>

@implementation DownSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithlist:(NSArray *)list height:(CGFloat)height{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = RGBACOLOR(160, 160, 160, 0);

        view = [[UITableView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, self.frame.size.height*31/48)style:UITableViewStylePlain];
    view.dataSource = self;
        view.delegate = self;
        listData = list;
        view.scrollEnabled = NO;
        [view setSeparatorColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"xian"]]];
        [self addSubview:view];
        
        [self animeData];
    }
    return self;
}

-(void)animeData{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    [UIView animateWithDuration:.25 animations:^{
        self.backgroundColor = RGBACOLOR(160, 160, 160, .4);
        [UIView animateWithDuration:.25 animations:^{
            [view setFrame:CGRectMake(view.frame.origin.x, ScreenHeight-view.frame.size.height, view.frame.size.width, view.frame.size.height)];
        }];
    } completion:^(BOOL finished) {
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:[self class]]){
        return YES;
    }
    return NO;
}

-(void)tappedCancel{
    [UIView animateWithDuration:.25 animations:^{
        [view setFrame:CGRectMake(0, 0,ScreenWidth, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)showInView:(UIViewController *)Sview
{
    if(Sview==nil){
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    }else{
    //[view addSubview:self];
        [Sview.view addSubview:self];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [UITableViewCell new];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (indexPath.row ==0) {
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shangtu"]];
            
            _label1 = [[UILabel alloc]init];
            _label1.text = @"分享到";
            _label1.textColor = [UIColor grayColor];
            _label1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            _label1.textAlignment = NSTextAlignmentCenter;
            _label1.lineBreakMode = NSLineBreakByWordWrapping;
            _label1.font = [UIFont fontWithName:@"AmericanTypewriter" size:18];
            [_label1 sizeToFit];
            _label1.adjustsFontSizeToFitWidth = YES;
            _label1.userInteractionEnabled = YES;
            [cell.contentView addSubview:_label1];
            [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(10);
            }];
            
            UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, cell.contentView.frame.size.width, cell.contentView.frame.size.height *3)];
            scrollView.backgroundColor = [UIColor redColor];
            [cell.contentView addSubview:scrollView];
            
            UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width *1.149, cell.contentView.frame.size.height *3)];
            view2.backgroundColor = [UIColor blueColor];
            //创建微信按钮
            UIButton *btn = [[UIButton alloc]init];
            btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"weixin"]];
            [view2 addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(view2.mas_top).offset(10);
                make.left.mas_equalTo(view2.mas_left).offset(10);
                make.size.mas_equalTo(CGSizeMake(61, 61));
            }];
            //创建分享到微信的那个label2
            
          UILabel * label1 = [[UILabel alloc]init];
            label1.text = @"微信好友";
            label1.textColor = [UIColor grayColor];
            label1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            label1.textAlignment = NSTextAlignmentCenter;
            label1.lineBreakMode = NSLineBreakByWordWrapping;
            label1.font = [UIFont fontWithName:@"AmericanTypewriter" size:14];
            [label1 sizeToFit];
            label1.adjustsFontSizeToFitWidth = YES;
            label1.userInteractionEnabled = YES;
            [view2 addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(btn.mas_centerX);
                make.top.mas_equalTo(btn.mas_bottom).offset(10);
            }];
            //创建分享到朋友圈的按钮
            UIButton *btn2 = [[UIButton alloc]init];
            btn2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pengyouquan"]];
            [view2 addSubview:btn2];
            [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(btn.mas_right).offset(10);
                make.top.mas_equalTo(btn.mas_top);
                make.size.mas_equalTo(CGSizeMake(61, 61));
            }];
            //创建分享到朋友圈的label
            
            UILabel * label2 = [[UILabel alloc]init];
            label2.text = @"朋友圈";
            label2.textColor = [UIColor grayColor];
            label2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            label2.textAlignment = NSTextAlignmentCenter;
            label2.lineBreakMode = NSLineBreakByWordWrapping;
            label2.font = [UIFont fontWithName:@"AmericanTypewriter" size:14];
            [label2 sizeToFit];
            label2.adjustsFontSizeToFitWidth = YES;
            label2.userInteractionEnabled = YES;
            [view2 addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(btn2.mas_centerX);
                make.top.mas_equalTo(btn2.mas_bottom).offset(10);
            }];
            
            UIButton *btn3 = [[UIButton alloc]init];
            btn3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xinlang"]];
            
            [btn3 addTarget:self action:@selector(clicksina:) forControlEvents:UIControlEventTouchUpInside];
            [view2 addSubview:btn3];
            [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(btn2.mas_right).offset(10);
                make.top.mas_equalTo(btn.mas_top);
                make.size.mas_equalTo(CGSizeMake(61, 61));
            }];
            //创建新浪微博那个label3
            
            UILabel * label3 = [[UILabel alloc]init];
            label3.text = @"新浪微博";
            label3.textColor = [UIColor grayColor];
            label3.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            label3.textAlignment = NSTextAlignmentCenter;
            label3.lineBreakMode = NSLineBreakByWordWrapping;
            label3.font = [UIFont fontWithName:@"AmericanTypewriter" size:14];
            [label3 sizeToFit];
            label3.adjustsFontSizeToFitWidth = YES;
            label3.userInteractionEnabled = YES;
            [view2 addSubview:label3];
            [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(btn3.mas_centerX);
                make.top.mas_equalTo(btn3.mas_bottom).offset(10);
            }];
            
            
            UIButton *btn4 = [[UIButton alloc]init];
            btn4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qq"]];
            [view2 addSubview:btn4];
            [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(btn3.mas_right).offset(10);
                make.top.mas_equalTo(btn.mas_top);
                make.size.mas_equalTo(CGSizeMake(61, 61));
            }];
            //创建qq好友label4
            UILabel * label4 = [[UILabel alloc]init];
            label4.text = @"QQ好友";
            label4.textColor = [UIColor grayColor];
            label4.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            label4.textAlignment = NSTextAlignmentCenter;
            label4.lineBreakMode = NSLineBreakByWordWrapping;
            label4.font = [UIFont fontWithName:@"AmericanTypewriter" size:14];
            [label4 sizeToFit];
            label4.adjustsFontSizeToFitWidth = YES;
            label4.userInteractionEnabled = YES;
            [view2 addSubview:label4];
            [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(btn4.mas_centerX);
                make.top.mas_equalTo(btn4.mas_bottom).offset(10);
            }];
            

            UIButton *btn5 = [[UIButton alloc]init];
            btn5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kongjian"]];
            [view2 addSubview:btn5];
            [btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(btn4.mas_right).offset(10);
                make.top.mas_equalTo(btn.mas_top);
                make.size.mas_equalTo(CGSizeMake(61, 61));
            }];
            //创建QQ空间那个label
            UILabel * label5 = [[UILabel alloc]init];
            label5.text = @"QQ好友";
            label5.textColor = [UIColor grayColor];
            label5.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            label5.textAlignment = NSTextAlignmentCenter;
            label5.lineBreakMode = NSLineBreakByWordWrapping;
            label5.font = [UIFont fontWithName:@"AmericanTypewriter" size:14];
            [label5 sizeToFit];
            label5.adjustsFontSizeToFitWidth = YES;
            label5.userInteractionEnabled = YES;
            [view2 addSubview:label5];
            [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(btn5.mas_centerX);
                make.top.mas_equalTo(btn5.mas_bottom).offset(10);
            }];
            
           [scrollView addSubview:view2];
            
            ////如果滚动，必须告诉滚动视图它的滚动区域有多少，只有滚动区域超出了它的显示范围，才会滚动
            scrollView.contentSize = view2.frame.size;
            ////不显示横向滚动条
            scrollView.showsHorizontalScrollIndicator = NO;
            ////不显示竖向
            scrollView.showsVerticalScrollIndicator = NO;
            ////去掉边缘弹跳效果
            scrollView.bounces = NO;
            ////让内容可以缩放，配置滚动视图的最大最小缩放比率
            scrollView.maximumZoomScale = 1;
            scrollView.minimumZoomScale = 0.2;
            ////缩放需要实现代理
            scrollView.delegate = self;
            view2.tag = 1000;
            
        }else if (indexPath.row ==1){
            cell.backgroundColor = [UIColor greenColor];
            
            //创建刷新的那个按钮
            
            UIButton *btn = [[UIButton alloc]init];
            btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shengji"]];
            [cell.contentView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.left.mas_equalTo(cell.contentView.mas_left).offset(15);
                make.size.mas_equalTo(CGSizeMake(61, 61));
            }];
            //创建刷新的那个label
            UILabel * label1 = [[UILabel alloc]init];
            label1.text = @"刷新";
            label1.textColor = [UIColor grayColor];
            label1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            label1.textAlignment = NSTextAlignmentCenter;
            label1.lineBreakMode = NSLineBreakByWordWrapping;
            label1.font = [UIFont fontWithName:@"AmericanTypewriter" size:14];
            [label1 sizeToFit];
            label1.adjustsFontSizeToFitWidth = YES;
            label1.userInteractionEnabled = YES;
            [cell.contentView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(btn.mas_centerX);
                make.top.mas_equalTo(btn.mas_bottom).offset(10);
            }];
            
            //创建复制链接的那个按钮
            UIButton *btn2 = [[UIButton alloc]init];
            btn2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fuzhi"]];
            [cell.contentView addSubview:btn2];
            [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.left.mas_equalTo(btn.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(61, 61));
            }];
            //创建复制链接的那个按钮
            UILabel * label2 = [[UILabel alloc]init];
            label2.text = @"复制链接";
            label2.textColor = [UIColor grayColor];
            label2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            label2.textAlignment = NSTextAlignmentCenter;
            label2.lineBreakMode = NSLineBreakByWordWrapping;
            label2.font = [UIFont fontWithName:@"AmericanTypewriter" size:14];
            [label2 sizeToFit];
            label2.adjustsFontSizeToFitWidth = YES;
            label2.userInteractionEnabled = YES;
            [cell.contentView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(btn2.mas_centerX);
                make.top.mas_equalTo(btn2.mas_bottom).offset(10);
            }];
            
            //创建分享到浏览器的那个按钮
            
            UIButton *btn3 = [[UIButton alloc]init];
            btn3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fuzhi"]];
            [cell.contentView addSubview:btn3];
            [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.left.mas_equalTo(btn2.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(61, 61));
            }];
            //创建在Safari打开的那个按钮
            
            UILabel * label3 = [[UILabel alloc]init];
            label3.text = @"在Safari打开";
            label3.textColor = [UIColor grayColor];
            label3.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            label3.textAlignment = NSTextAlignmentCenter;
            label3.lineBreakMode = NSLineBreakByWordWrapping;
            label3.font = [UIFont fontWithName:@"AmericanTypewriter" size:14];
            [label3 sizeToFit];
            label3.adjustsFontSizeToFitWidth = YES;
            label3.userInteractionEnabled = YES;
            [cell.contentView addSubview:label3];
            [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(btn3.mas_centerX);
                make.top.mas_equalTo(btn3.mas_bottom).offset(10);
            }];
            
            
        }else if (indexPath.row==2){
            cell.backgroundColor = [UIColor redColor];
        //创建取消的那个按钮
            UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cancelBtn.backgroundColor = [UIColor blackColor];
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
            [cancelBtn addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:cancelBtn];
            [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            
        }
    return cell;
}
-(void)clickCancel:(UIButton *)sender{
    NSLog(@"点击取消按钮");
    
    [UIView animateWithDuration:.25 animations:^{
        [view setFrame:CGRectMake(0, ScreenHeight,ScreenWidth, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      NSLog(@"你点了相应的单元格了");
    [UIView animateWithDuration:.25 animations:^{
        [view setFrame:CGRectMake(0, ScreenHeight,ScreenWidth, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return self.frame.size.height *136/480;
    }else if (indexPath.row ==1){
        return self.frame.size.height *123/480;
    }
    return self.frame.size.height *50/480;
}

-(void)clicksina:(UIButton *)sender{
    NSLog(@"点击的新浪分享的那个按钮");
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"http://www.sina.com";
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    
    [WeiboSDK sendRequest:request];
    
    
}


#pragma mark---新浪分享方法
- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = NSLocalizedString(@"测试通过weiboSDK发送文字到微博", nil);
    return message;
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
