//
//  TJ_PersonalCenterController.m
//  金堂
//
//  Created by SDKJ on 16/5/26.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_PersonalCenterController.h"
#import "UIView_extra.h"
#import "MolonDebug.h"
#import "TJ_BAButton.h"
#import "TJ_EditingDataController.h"

@implementation TJ_PersonalCenterController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    UIButton *themeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    themeButton.adjustsImageWhenHighlighted = NO;
    themeButton.frame = CGRectMake(0, 0, self.view.width, self.view.height * 0.3f);
    [themeButton setBackgroundImage:[UIImage imageNamed:@"beijing"] forState:UIControlStateNormal];
    [self.view addSubview:themeButton];
    [themeButton addTarget:self action:@selector(clickThemeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.adjustsImageWhenHighlighted = NO;
    backButton.frame = CGRectMake(10, 20, 20, 20);
    [backButton addTarget:self action:@selector(clickBackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[[UIImage imageNamed:@"xiaoyufu_01"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    
    TJ_BACustomButton *nickNameButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusCenter];
    nickNameButton.frame = CGRectMake(backButton.right, backButton.y, self.view.width - 2 * backButton.width, backButton.height);
    nickNameButton.enabled = NO;
    [nickNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:nickNameButton];
    [nickNameButton setTitle:@"Tang" forState:UIControlStateNormal];
    [nickNameButton setImage:[UIImage imageNamed:@"nan"] forState:UIControlStateNormal];
    
    TJ_BACustomButton *headButton = [TJ_BACustomButton BA_ShareButton];
    headButton.frame = CGRectMake(0, 0, themeButton.height * 0.3f, themeButton.height * 0.3f);
    headButton.center = themeButton.center;
    headButton.adjustsImageWhenHighlighted = NO;
    headButton.buttonCornerRadius = headButton.width * 0.5f;
    [self.view addSubview:headButton];
    [headButton addTarget:self action:@selector(clickHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headButton setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    
    UILabel *fansLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headButton.bottom, (self.view.width - 20) * 0.5f, headButton.height * 0.5f)];
    fansLabel.textColor = [UIColor whiteColor];
    fansLabel.font = [UIFont systemFontOfSize:15];
    fansLabel.textAlignment = NSTextAlignmentRight;
    fansLabel.text = @"粉丝 0";
    [self.view addSubview:fansLabel];
    
    UILabel *concernLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headButton.bottom, fansLabel.width, fansLabel.height)];
    concernLabel.right = self.view.width;
    concernLabel.textColor = fansLabel.textColor;
    concernLabel.font = fansLabel.font;
    concernLabel.textAlignment = NSTextAlignmentLeft;
    concernLabel.text = @"关注 10";
    [self.view addSubview:concernLabel];
    
    UILabel *signatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(concernLabel.frame), self.view.width, themeButton.bottom - CGRectGetMaxY(concernLabel.frame))];
    signatureLabel.font = [UIFont systemFontOfSize:13];
    signatureLabel.textColor = [UIColor whiteColor];
    signatureLabel.textAlignment = NSTextAlignmentCenter;
    signatureLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    signatureLabel.backgroundColor = [UIColor colorWithWhite:0.306 alpha:0.580];
    signatureLabel.text = @"相爱不一定分开。。。";
    [self.view addSubview:signatureLabel];
    
    TJ_BACustomButton *editingButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusCenter];
    editingButton.frame = CGRectMake(self.view.width * 0.35f, themeButton.bottom + 3, self.view.width * 0.3f, 30);
    editingButton.buttonCornerRadius = 5.f;
    [editingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    editingButton.adjustsImageWhenHighlighted = NO;
    [editingButton setTitle:@"编辑资料" forState:UIControlStateNormal];
    [editingButton setImage:[UIImage imageNamed:@"qianbi_01"] forState:UIControlStateNormal];
    editingButton.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:editingButton];
    [editingButton addTarget:self action:@selector(clickEditingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, editingButton.bottom + 3.f, self.view.width, self.view.height - editingButton.bottom - 3.f)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor lightGrayColor];
}

#pragma mark Actions
//点击头像按钮
- (void)clickHeadButtonAction:(TJ_BACustomButton *)sender
{
    DLOG(@"sdfs");
    UIImageView *imageView = [[UIImageView alloc] initWithImage:sender.currentImage];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.center = self.view.center;
    imageView.userInteractionEnabled = YES;
    imageView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:imageView];
    
    [UIView animateWithDuration:0.5f animations:^{
        imageView.frame = self.view.bounds;
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
        [imageView addGestureRecognizer:tapGestureRecognizer];
    }];
}
//点击头像图片取消浏览
- (void)tapGestureRecognizer:(UIGestureRecognizer *)gesture
{
    [UIView animateWithDuration:0.5f animations:^{
        CGRect frame = gesture.view.frame;
        frame.size.width = 0.f;
        frame.size.height = 0.f;
        gesture.view.frame = frame;
        gesture.view.center = self.view.center;
    } completion:^(BOOL finished) {
        [gesture.view removeFromSuperview];
    }];
}

//点击后退按钮
- (void)clickBackButtonAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//点击主题按钮
- (void)clickThemeButtonAction:(UIButton *)sender
{
    DLOG(@"themeButton?????");
}
//点击编辑资料
- (void)clickEditingButtonAction:(TJ_BACustomButton *)sender
{
    DLOG(@"编辑资料");
    TJ_EditingDataController *editingDataController = [[TJ_EditingDataController alloc] init];
    [self presentViewController:editingDataController animated:NO completion:nil];
}

@end
