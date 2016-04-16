//
//  TJ_CommetView.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/16.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_CommetView.h"

@implementation TJ_CommetView

- (instancetype)init
{
    if (self = [super init]) {
        UIImageView *image = [UIImageView new];
        [self addSubview:image];
        image.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
        image.image = [[UIImage imageNamed:@"LikeCmtBg"] stretchableImageWithLeftCapWidth:50 topCapHeight:30];
    }
    
    return self;
}

- (void)setCommetData:(NSArray *)commetData
{
    if (!commetData.count) {
        self.height = 0;
        self.fixedHeight = @0;
    }
    CGFloat margin = 5;
    UIView *view = self;
    for (NSInteger i = 0; i < commetData.count; i++)
    {
        self.commentLable = [UILabel new];
        self.commetPersonButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusNormal];
        [self addSubview:self.commetPersonButton];
        [self addSubview:self.commentLable];
        
        self.commetPersonButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.commetPersonButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [self.commetPersonButton setTitle:@"阿肯会发觉" forState:UIControlStateNormal];
        CGRect frame = [self.commetPersonButton getButtonWidth];
        self.commetPersonButton.sd_layout
        .topSpaceToView(view, margin * 2)
        .leftSpaceToView(self, margin)
        .widthIs(frame.size.width)
        .heightIs(frame.size.height);

        self.commentLable.font = self.commetPersonButton.titleLabel.font;
        self.commentLable.textColor = [UIColor colorWithWhite:0.249 alpha:1.000];
        self.commentLable.text = @": 啊可怜的风景阿萨德发 i 阿双方 i 可是当分开了大师分公司的风格";
        self.commentLable.sd_layout
        .topEqualToView(self.commetPersonButton)
        .leftSpaceToView(self.commetPersonButton, 1)
        .rightSpaceToView(self, margin)
        .autoHeightRatio(0);
        
        view = self.commentLable;
    }

    [self setupAutoHeightWithBottomView:view bottomMargin:margin];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
