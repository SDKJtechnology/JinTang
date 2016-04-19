//
//  TJ_StartView.m
//  金堂
//
//  Created by SDKJ on 16/4/19.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_CycleScrollView.h"
#import <UIImageView+WebCache.h>

#define selfWidth self.frame.size.width
#define selfHeight self.frame.size.height

@interface TJ_CycleScrollView ()<UIScrollViewDelegate>
{
    NSInteger pageIndex;
    
    BOOL isDragging;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *iamgeView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TJ_CycleScrollView

@synthesize timer = timer;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.bounces = NO;
        [self addSubview:self.scrollView];
        
        self.pageControl = [UIPageControl new];
        [self addSubview:self.pageControl];
        self.pageControllStyle = TJ_CycleScrollViewPageControlStyleDownCenter;
        
        pageIndex = 0;
        self.interval = 2;
    }
    return self;
}

- (void)setImageGroup:(NSArray *)imageGroup
{
    _imageGroup = imageGroup;
    NSInteger i = 0;
    for (NSString *imageName in imageGroup) {
        self.iamgeView = [UIImageView new];
        self.iamgeView.image = [UIImage imageNamed:imageName];
        self.iamgeView.frame = CGRectMake(i * selfWidth, 0, selfWidth, selfHeight);
        [self.scrollView addSubview:self.iamgeView];
        i++;
    }
    if (imageGroup.count > 1)
        [self setTimer];
    if (self.cycleModel == TJ_CycleScrollViewCycleModel) {
        self.iamgeView = [UIImageView new];
        self.iamgeView.image = [UIImage imageNamed:imageGroup.firstObject];
        self.iamgeView.frame = CGRectMake(i * selfWidth, 0, selfWidth, selfHeight);
        [self.scrollView addSubview:self.iamgeView];
        i++;
    }
    self.scrollView.contentSize = CGSizeMake(i * selfWidth, selfHeight);
    self.pageControl.numberOfPages = imageGroup.count;
    [self setPageControllFrame:[self.pageControl sizeForNumberOfPages:imageGroup.count]];
}

- (void)setImageUrlGroup:(NSArray<NSString *> *)imageUrlGroup
{
    _imageGroup = imageUrlGroup;
    NSInteger i = 0;
    for (NSString *imageUrl in imageUrlGroup) {
        self.iamgeView = [UIImageView new];
        [self.iamgeView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:self.placeholderImage];
        self.iamgeView.frame = CGRectMake(i * selfWidth, 0, selfWidth, selfHeight);
        [self.scrollView addSubview:self.iamgeView];
        i++;
    }
    if (imageUrlGroup.count > 1)
        [self setTimer];
    if (self.cycleModel == TJ_CycleScrollViewCycleModel) {
        self.iamgeView = [UIImageView new];
        [self.iamgeView sd_setImageWithURL:[NSURL URLWithString:imageUrlGroup.firstObject] placeholderImage:self.placeholderImage];
        self.iamgeView.frame = CGRectMake(i * selfWidth, 0, selfWidth, selfHeight);
        [self.scrollView addSubview:self.iamgeView];
        i++;
    }
    self.scrollView.contentSize = CGSizeMake(i * selfWidth, selfHeight);
    self.pageControl.numberOfPages = imageUrlGroup.count;
    [self setPageControllFrame:[self.pageControl sizeForNumberOfPages:imageUrlGroup.count]];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    pageIndex = scrollView.contentOffset.x / selfWidth;
    self.pageControl.currentPage = floor((scrollView.contentOffset.x - selfWidth / 2) / selfWidth) + 1;

    if (pageIndex == self.imageGroup.count - 1 && self.cycleModel == TJ_CycleScrollViewStartPageModel)
    {
        [self.timer invalidate];
        [UIView animateWithDuration:1 delay:self.interval options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    if (pageIndex == self.imageGroup.count && !isDragging) {
        pageIndex = 0;
        self.pageControl.currentPage = 0;
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    
    if (([scrollView.panGestureRecognizer velocityInView:self].x) > 0 && scrollView.contentOffset.x < selfWidth && self.cycleModel == TJ_CycleScrollViewCycleModel)
    {
        isDragging = YES;
        pageIndex = self.imageGroup.count;
        self.pageControl.currentPage = self.imageGroup.count;
        [self.scrollView setContentOffset:CGPointMake(self.imageGroup.count * selfWidth, 0) animated:NO];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setTimer];
    isDragging = NO;
}

#pragma mark Other

- (void)setTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(scrollImageView) userInfo:nil repeats:YES];
}

- (void)setShowPageControl:(BOOL)showPageControl
{
    self.pageControl.hidden = showPageControl;
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (void)setPageControllFrame:(CGSize)size
{
    switch (self.pageControllStyle) {
        case TJ_CycleScrollViewPageControlStyleDownCenter:
        {
            CGPoint center = self.scrollView.center;
            center.y = center.y * 2 - 20;
            self.pageControl.center = center;
            break;
        }
        case TJ_CycleScrollViewPageControlStyleDownLeft:
        {
            CGRect frame = self.pageControl.frame;
            frame.origin.x = size.width / 2 + 20;
            frame.origin.y = selfHeight - 20;
            self.pageControl.frame = frame;
            break;
        }
        case TJ_CycleScrollViewPageControlStyleDownRight:
        {
            CGRect frame = self.pageControl.frame;
            frame.origin.x = selfWidth - size.width / 2 - 20;
            frame.origin.y = selfHeight - 20;
            self.pageControl.frame = frame;
            break;
        }
        case TJ_CycleScrollViewPageControlStyleTopCenter:
        {
            CGPoint center = self.scrollView.center;
            center.y = 40;
            self.pageControl.center = center;
            break;
        }
    }
}

- (void)scrollImageView
{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = selfWidth * (pageIndex + 1);
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
