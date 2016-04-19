//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "TJ_LeftSortsViewController.h"
#import "TJ_LeftSlideViewController.h"
#import "AppDelegate.h"
#import "SDAutoLayout.h"
#import "TJ_BAButton.h"

@interface TJ_LeftSortsViewController ()

/**
 *  登陆按钮
 */
@property (nonatomic, strong) TJ_BACustomButton *landingButton;
/**
 *  关注按钮
 */
@property (nonatomic, strong) TJ_BACustomButton *concernButton;
/**
 *  粉丝按钮
 */
@property (nonatomic, strong) TJ_BACustomButton *fansButton;
/**
 *  圈子按钮
 */
@property (nonatomic, strong) TJ_BACustomButton *circleButton;
/**
 *  收藏按钮
 */
@property (nonatomic, strong) TJ_BACustomButton *enshrineButton;
/**
 *  帖子按钮
 */
@property (nonatomic, strong) TJ_BACustomButton *invitationButton;
/**
 *  设置按钮
 */
@property (nonatomic, strong) TJ_BACustomButton *setingButton;
/**
 *  注册按钮
 */
@property (nonatomic, strong) TJ_BACustomButton *logingButton;
/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *headImgae;
/**
 *  昵称label
 */
@property (nonatomic, strong) UILabel *nickNameLabel;
/**
 *  签名label
 */
@property (nonatomic, strong) UILabel *signatureLabel;

@property (nonatomic, strong) UIImageView *indicateImage;

@property (nonatomic, strong) UIView *landingView;

@end

@implementation TJ_LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addSubviews];
}
//添加子视图
- (void)addSubviews
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"beijing"];
    
    self.landingView = [UIView new];
    
    self.headImgae = [UIImageView new];
    self.headImgae.image = [UIImage imageNamed:@"img_03"];
    
    self.nickNameLabel = [UILabel new];
    self.nickNameLabel.text = @"点击登陆";
    self.nickNameLabel.font = [UIFont systemFontOfSize:20];
    self.nickNameLabel.textColor = [UIColor whiteColor];
    
    self.signatureLabel = [UILabel new];
    self.signatureLabel.text = @"登陆后查看更多";
    self.signatureLabel.font = [UIFont systemFontOfSize:13];
    self.signatureLabel.textColor = [UIColor whiteColor];
    
    self.indicateImage = [UIImageView new];
    self.indicateImage.image = [UIImage imageNamed:@"img_09"];
    
    [self.landingView sd_addSubviews:@[self.headImgae,self.nickNameLabel,self.signatureLabel,self.indicateImage]];
    
    self.landingButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusNormal];
    [self.landingButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.landingButton.tag = TJ_BACustomButtonTagLandingButton;
    
    self.concernButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusTop];
    [self.concernButton setImage:[UIImage imageNamed:@"img_15"] forState:UIControlStateNormal];
    [self.concernButton setTitle:@"关注" forState:UIControlStateNormal];
    self.concernButton.tag = TJ_BACustomButtonTagConcernButton;
    [self.concernButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.circleButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusTop];
    [self.circleButton setImage:[UIImage imageNamed:@"pyquan"] forState:UIControlStateNormal];
    [self.circleButton setTitle:@"朋友圈" forState:UIControlStateNormal];
    self.circleButton.tag = TJ_BACustomButtonTagCircleButton;
    [self.circleButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.fansButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusTop];
    [self.fansButton setImage:[UIImage imageNamed:@"img_19"] forState:UIControlStateNormal];
    [self.fansButton setTitle:@"粉丝" forState:UIControlStateNormal];
    self.fansButton.tag = TJ_BACustomButtonTagFansButton;
    [self.fansButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.enshrineButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusTop];
    [self.enshrineButton setImage:[UIImage imageNamed:@"img_06"] forState:UIControlStateNormal];
    [self.enshrineButton setTitle:@"收藏" forState:UIControlStateNormal];
    self.enshrineButton.tag = TJ_BACustomButtonTagEnshrineButton;
    [self.enshrineButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.invitationButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusTop];
    [self.invitationButton setImage:[UIImage imageNamed:@"img_26"] forState:UIControlStateNormal];
    [self.invitationButton setTitle:@"帖子" forState:UIControlStateNormal];
    self.invitationButton.tag = TJ_BACustomButtonTagInvitationButton;
    [self.invitationButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.setingButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusNormal];
    [self.setingButton setTitle:@"设置 " forState:UIControlStateNormal];
    self.setingButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.setingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.setingButton.tag = TJ_BACustomButtonTagSetingButton;
    [self.setingButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.logingButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusNormal];
    [self.logingButton setTitle:@"注册" forState:UIControlStateNormal];
    self.logingButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.logingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.logingButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.logingButton.tag = TJ_BACustomButtonTagLogingButton;
    
    [self.view sd_addSubviews:@[imageview,self.landingView,self.landingButton,self.concernButton,self.circleButton,self.invitationButton,self.fansButton,self.enshrineButton,self.setingButton,self.logingButton]];
}
//即将布局子视图
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat margin = 30;
    CGFloat rate = 0.8;
    if (kScreenWidth > 320)
        margin = 50;
    else
        rate = 0.5;
    
    CGFloat buttonH = 50;
    
    self.landingView.sd_layout
    .topSpaceToView(self.view, self.view.height * 0.1)
    .leftSpaceToView(self.view, margin)
    .rightSpaceToView(self.view, kMainPageDistance + margin)
    .autoHeightRatio(0.25);
    
    self.headImgae.sd_layout
    .topSpaceToView(self.landingView, 0)
    .leftSpaceToView(self.landingView, 0)
    .bottomSpaceToView(self.landingView, 0)
    .widthIs(self.headImgae.height * 0.8);

    self.indicateImage.sd_layout
    .rightSpaceToView(self.landingView, 0)
    .centerYIs(self.landingView.height / 2)
    .heightIs(25)
    .widthIs(15);
    
    self.nickNameLabel.sd_layout
    .topSpaceToView(self.landingView, 0)
    .rightSpaceToView(self.indicateImage, 0)
    .leftSpaceToView(self.headImgae, margin * 0.3)
    .heightIs(self.landingView.height / 2);
    
    self.signatureLabel.sd_layout
    .leftEqualToView(self.nickNameLabel)
    .bottomSpaceToView(self.landingView, 0)
    .rightEqualToView(self.nickNameLabel)
    .heightIs(self.landingView.height / 2);
    
    self.landingButton.sd_layout
    .topSpaceToView(self.view, self.view.height * 0.1)
    .leftSpaceToView(self.view, margin)
    .rightSpaceToView(self.view, kMainPageDistance + margin)
    .autoHeightRatio(0.25);
    
    self.concernButton.sd_layout
    .topSpaceToView(self.landingButton, margin * rate)
    .leftEqualToView(self.landingButton)
    .rightEqualToView(self.landingButton)
    .heightIs(buttonH);
    
    self.fansButton.sd_layout
    .topSpaceToView(self.concernButton, margin * rate)
    .leftEqualToView(self.landingButton)
    .rightEqualToView(self.landingButton)
    .heightIs(buttonH);
    
    self.circleButton.sd_layout
    .topSpaceToView(self.fansButton, margin * rate)
    .leftEqualToView(self.landingButton)
    .rightEqualToView(self.landingButton)
    .heightIs(buttonH);
    
    self.invitationButton.sd_layout
    .topSpaceToView(self.circleButton, margin * rate)
    .leftEqualToView(self.landingButton)
    .rightEqualToView(self.landingButton)
    .heightIs(buttonH);
    
    self.enshrineButton.sd_layout
    .topSpaceToView(self.invitationButton, margin * rate)
    .leftEqualToView(self.landingButton)
    .rightEqualToView(self.landingButton)
    .heightIs(buttonH);
    
    self.setingButton.sd_layout
    .bottomSpaceToView(self.view, margin * (rate - 0.3))
    .leftEqualToView(self.landingButton)
    .widthIs(buttonH)
    .heightIs(buttonH);
    
    self.logingButton.sd_layout
    .bottomEqualToView(self.setingButton)
    .rightEqualToView(self.landingButton)
    .widthIs(buttonH)
    .heightIs(buttonH);
    
}
//点击按钮
- (void)clickButtonAction:(TJ_BACustomButton *)sender
{
    Class myClass = [UIViewController class];
    switch (sender.tag) {
        case TJ_BACustomButtonTagLandingButton:

            myClass = NSClassFromString(@"LX_login2ViewController");
            NSLog(@"landingButton  %ld",TJ_BACustomButtonTagLandingButton);
            break;
        case TJ_BACustomButtonTagConcernButton:
            NSLog(@"ConcernButton  %ld",TJ_BACustomButtonTagConcernButton);
            break;
        case TJ_BACustomButtonTagFansButton:
            NSLog(@"FansButton  %ld",TJ_BACustomButtonTagFansButton);
            break;
        case TJ_BACustomButtonTagCircleButton:
            NSLog(@"CircleButton  %ld",TJ_BACustomButtonTagCircleButton);
            break;
        case TJ_BACustomButtonTagEnshrineButton:
            NSLog(@"EnshrineButton  %ld",TJ_BACustomButtonTagEnshrineButton);
            break;
        case TJ_BACustomButtonTagInvitationButton:
            NSLog(@"InvitationButton  %ld",TJ_BACustomButtonTagInvitationButton);
            break;
        case TJ_BACustomButtonTagSetingButton:
            myClass = NSClassFromString(@"TJ_SetingViewController");
            break;
        case TJ_BACustomButtonTagLogingButton:
            myClass = NSClassFromString(@"LX_enrollViewController");
            NSLog(@"LogingButton  %ld",TJ_BACustomButtonTagLogingButton);
            break;
    }
    UIViewController *viewController = [myClass new];
    viewController.view.backgroundColor = [UIColor whiteColor];
    self.closeLeftVC(viewController);
    [self presentViewController:viewController];
}

//弹出视图
- (void)presentViewController:(UIViewController *)viewController
{
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    [viewController.view addSubview:navigationBar];
    navigationBar.barStyle = UIBarStyleDefault;
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:viewController.navigationItem.title];
    item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(dismissViewController)];
    [navigationBar pushNavigationItem:item animated:YES];
    navigationBar.barTintColor = [UIColor colorWithRed:0.239 green:0.638 blue:0.955 alpha:1.000];
    navigationBar.tintColor = [UIColor whiteColor];
    [navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-BoldOblique" size:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self presentViewController:viewController animated:NO completion:^{}];
}

- (void)dismissViewController
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
