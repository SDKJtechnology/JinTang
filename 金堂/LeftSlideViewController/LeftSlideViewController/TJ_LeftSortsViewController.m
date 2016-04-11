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


@end

@implementation TJ_LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    [self addSubviews];
}

- (void)addSubviews
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"beijing"];
    
    self.landingButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusNormal];
    [self.landingButton setImage:[UIImage imageNamed:@"denglu"] forState:UIControlStateNormal];
    
    self.concernButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusTop];
    [self.concernButton setImage:[UIImage imageNamed:@"img_15"] forState:UIControlStateNormal];
    [self.concernButton setTitle:@"关注" forState:UIControlStateNormal];
    
    self.circleButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusTop];
    [self.circleButton setImage:[UIImage imageNamed:@"img_23"] forState:UIControlStateNormal];
    [self.circleButton setTitle:@"朋友圈" forState:UIControlStateNormal];
    
    self.fansButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusTop];
    [self.fansButton setImage:[UIImage imageNamed:@"img_19"] forState:UIControlStateNormal];
    [self.fansButton setTitle:@"粉丝" forState:UIControlStateNormal];
    
    self.enshrineButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusTop];
    [self.enshrineButton setImage:[UIImage imageNamed:@"img_06"] forState:UIControlStateNormal];
    [self.enshrineButton setTitle:@"收藏" forState:UIControlStateNormal];
    
    self.invitationButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusTop];
    [self.invitationButton setImage:[UIImage imageNamed:@"img_26"] forState:UIControlStateNormal];
    [self.invitationButton setTitle:@"帖子" forState:UIControlStateNormal];
    
    self.setingButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusNormal];
    [self.setingButton setTitle:@"设置 " forState:UIControlStateNormal];
    self.setingButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.setingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.logingButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusNormal];
    [self.logingButton setTitle:@"注册" forState:UIControlStateNormal];
    self.logingButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.logingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.logingButton addTarget:self action:@selector(clickLandingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view sd_addSubviews:@[imageview,self.landingButton,self.concernButton,self.circleButton,self.invitationButton,self.fansButton,self.enshrineButton,self.setingButton,self.logingButton]];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat margin = 30;
    CGFloat buttonH = 50;
    
    self.landingButton.sd_layout
    .topSpaceToView(self.view, self.view.height * 0.1)
    .leftSpaceToView(self.view, margin)
    .rightSpaceToView(self.view, kMainPageDistance + margin)
    .autoHeightRatio(0.35);
    
    self.concernButton.sd_layout
    .topSpaceToView(self.landingButton, margin * 0.5)
    .leftEqualToView(self.landingButton)
    .rightEqualToView(self.landingButton)
    .heightIs(buttonH);
    
    self.fansButton.sd_layout
    .topSpaceToView(self.concernButton, margin * 0.5)
    .leftEqualToView(self.landingButton)
    .rightEqualToView(self.landingButton)
    .heightIs(buttonH);
    
    self.circleButton.sd_layout
    .topSpaceToView(self.fansButton, margin * 0.5)
    .leftEqualToView(self.landingButton)
    .rightEqualToView(self.landingButton)
    .heightIs(buttonH);
    
    self.invitationButton.sd_layout
    .topSpaceToView(self.circleButton, margin * 0.5)
    .leftEqualToView(self.landingButton)
    .rightEqualToView(self.landingButton)
    .heightIs(buttonH);
    
    self.enshrineButton.sd_layout
    .topSpaceToView(self.invitationButton, margin * 0.5)
    .leftEqualToView(self.landingButton)
    .rightEqualToView(self.landingButton)
    .heightIs(buttonH);
    
    self.setingButton.sd_layout
    .bottomSpaceToView(self.view, margin * 0.5)
    .leftEqualToView(self.landingButton)
    .widthIs(buttonH)
    .heightIs(buttonH);
    
    self.logingButton.sd_layout
    .bottomEqualToView(self.setingButton)
    .rightEqualToView(self.landingButton)
    .widthIs(buttonH)
    .heightIs(buttonH);
    
}

- (void)clickLandingButtonAction:(TJ_BACustomButton *)sender
{
    NSLog(@"landingButton");
}

@end
