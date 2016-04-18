//
//  AdCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/12.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "AdCell.h"
#import "SDCycleScrollView.h"
#import "SDAutoLayout.h"

@interface AdCell()

@property (nonatomic) SDCycleScrollView *cycleScrollView;

@end

@implementation AdCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.cycleScrollView = [SDCycleScrollView new];
        [self.contentView addSubview:self.cycleScrollView];
        
        CGFloat margin = 10;
        
        self.cycleScrollView.sd_layout
        .topSpaceToView(self.contentView, margin)
        .leftSpaceToView(self.contentView, margin)
        .rightSpaceToView(self.contentView, margin)
        .autoHeightRatio(0.5);
        
        [self setupAutoHeightWithBottomView:self.cycleScrollView bottomMargin:margin];
        
        self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;// 分页控件位置
        self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;// 分页控件风格
        self.cycleScrollView.titleLabelBackgroundColor = [UIColor colorWithWhite:0.352 alpha:0.610];
        self.cycleScrollView.titlesGroup = @[@"撒旦发射的发生多福多寿风格",@"撒旦个地方是广东省各地热",@"撒旦发射的发生多福多寿风格",@"撒旦个地方是广东省各地热"];
        self.cycleScrollView.localizationImageNamesGroup = @[@"beijing",@"beijing",@"beijing",@"beijing"];
//        self.cycleScrollView.imageURLStringsGroup = imagesURLStrings;
        self.cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    }
    
    return self;
}

@end
