//
//  TJ_CycleScrollView.h
//
//  Created by SDKJ on 16/4/19.
//  Copyright © 2016年 luxia. All rights reserved.
//
//自动滚动视图（循环滚动视图）
#import <UIKit/UIKit.h>

//CycleScrollView模式
typedef NS_ENUM(NSInteger, TJ_CycleScrollViewModel)
{
    TJ_CycleScrollViewCycleModel,//默认的，无限循环模式，多用于广告视图
    TJ_CycleScrollViewStartPageModel//不循环模式，当滚动到最后一页后，视图将从父视图移除，一般用于启动页面
};

//pageControl位置状态
typedef NS_ENUM(NSInteger, TJ_CycleScrollViewPageControlStyle)
{
    TJ_CycleScrollViewPageControlStyleDownCenter = 0,
    TJ_CycleScrollViewPageControlStyleTopCenter,
    TJ_CycleScrollViewPageControlStyleDownLeft,
    TJ_CycleScrollViewPageControlStyleDownRight
};
/**
 *  本库运用了SDWebImage
 */

@interface TJ_CycleScrollView : UIView
/**
 *  默认的，无限循环模式，多用于广告视图
 */
@property (nonatomic, assign) TJ_CycleScrollViewModel cycleModel;
/**
 *  图片数组(可以是@“imageName”或者@"https://")
 */
@property (nonatomic, strong) NSArray *imageGroup;
/**
 *  站位图，用于网络图片还没加载成功的时候显示
 */
@property (nonatomic, strong) UIImage *placeholderImage;
/**
 *  滚动间隔时间,默认为2秒
 */
@property (nonatomic, assign) NSTimeInterval interval;
/**
 *  是否显示page指示器,默认YES
 */
@property (nonatomic, assign) BOOL showPageControl;
/**
 *  gage指示器颜色,默认浅灰色
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
/**
 *  当前指示器颜色，默认白色
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
/**
 *  page指示器位置状态,默认下居中
 */
@property (nonatomic , assign) TJ_CycleScrollViewPageControlStyle pageControllStyle;

@end
