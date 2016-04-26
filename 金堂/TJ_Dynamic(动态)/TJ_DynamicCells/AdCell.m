//
//  AdCell.m
//  金堂
//
//  Created by ZhangAnMing on 16/4/12.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "AdCell.h"
#import "SDAutoLayout.h"
#import "TJ_CycleScrollView.h"

@interface AdCell()

@property (nonatomic) TJ_CycleScrollView *cycleScrollView;

@end

@implementation AdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.cycleScrollView = [TJ_CycleScrollView new];
        [self.contentView addSubview:self.cycleScrollView];
        
        CGFloat margin = 10;
        
        self.cycleScrollView.sd_layout
        .topSpaceToView(self.contentView, margin)
        .leftSpaceToView(self.contentView, margin)
        .rightSpaceToView(self.contentView, margin)
        .autoHeightRatio(0.5);
        self.cycleScrollView.showPageControl = NO;
        self.cycleScrollView.titleLabelTextColor = [UIColor whiteColor];
        self.cycleScrollView.titleLabelBackgroundColor = [UIColor colorWithWhite:0.347 alpha:1.000];

        [self setupAutoHeightWithBottomView:self.cycleScrollView bottomMargin:margin];
//        self.cycleScrollView.pageControllStyle = TJ_CycleScrollViewPageControlStyleDownCenter;
//        self.cycleScrollView.titleLabelBackgroundColor = [UIColor colorWithWhite:0.352 alpha:0.610];
//        self.cycleScrollView.titlesGroup = @[@"撒旦发射的发生多福多寿风格",@"撒旦个地方是广东省各地热",@"撒旦发射的发生多福多寿风格",@"撒旦个地方是广东省各地热"];
//        self.cycleScrollView.localizationImageNamesGroup = @[@"beijing"];
//        self.cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    }
    
    return self;
}

- (void)setHotspotModel:(HotspotModel *)hotspotModel
{
    self.cycleScrollView.imageGroup = @[hotspotModel.hotspotImageUrl,hotspotModel.hotspotImageUrl,@"beijing",@"beijing"];
}

@end
