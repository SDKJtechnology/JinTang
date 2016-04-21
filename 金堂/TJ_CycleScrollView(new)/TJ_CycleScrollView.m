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
    
    NSArray *imageStrings;
    
    BOOL isDragging;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UILabel *titelLabel;

@property (nonatomic, weak) NSTimer *timer;

@end

@implementation TJ_CycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame])
    {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.bounces = NO;
        [self.scrollView.panGestureRecognizer setCancelsTouchesInView:NO
         ];        [self addSubview:self.scrollView];
        
        self.pageControl = [UIPageControl new];
        [self addSubview:self.pageControl];
        self.pageControl.hidesForSinglePage = YES;
        self.pageControllStyle = TJ_CycleScrollViewPageControlStyleDownCenter;
        self.showPageControl = YES;
        
        pageIndex = 0;
        self.interval = 2;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
}

- (void)setupImageView
{
    NSMutableArray *imageArray = [NSMutableArray arrayWithArray:imageStrings];
    if (self.imageGroup.count > 1 && self.cycleModel == TJ_CycleScrollViewCycleModel)
    {
        [imageArray addObject:imageStrings.firstObject];
    }
    NSInteger i = 0;
    for (NSString *imageString in imageArray) {
        self.imageView = [UIImageView new];
        if ([imageString hasPrefix:@"http"]) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"load"]];
        }
        else{
            self.imageView.image = [UIImage imageNamed:imageString];
        }
        self.imageView.frame = CGRectMake(i * selfWidth, 0, selfWidth, selfHeight);
        [self.scrollView addSubview:self.imageView];
        i++;
    }
    self.scrollView.contentSize = CGSizeMake(i * selfWidth, selfHeight);
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    pageIndex = scrollView.contentOffset.x / selfWidth;
    self.pageControl.currentPage = floor((scrollView.contentOffset.x - selfWidth / 2) / selfWidth) + 1;

    if (pageIndex == self.imageGroup.count - 1 && self.cycleModel == TJ_CycleScrollViewStartPageModel)
    {
        [_timer invalidate];
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
    [_timer invalidate];
    
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

#pragma mark Propertys

- (void)setImageGroup:(NSArray *)imageGroup
{
    _imageGroup = imageGroup;
    self.pageControl.hidden = !self.showPageControl;
    
    NSMutableArray *temp = [NSMutableArray new];
    [imageGroup enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * stop) {
        NSString *urlString;
        if ([obj isKindOfClass:[NSString class]]) {
            urlString = obj;
        } else if ([obj isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL *)obj;
            urlString = [url absoluteString];
        }
        if (urlString) {
            [temp addObject:urlString];
        }
    }];
    imageStrings = [temp copy];
    
    [self setTimer];
    [self setupImageView];
    
    self.pageControl.numberOfPages = imageGroup.count;
    [self setPageControllFrame:[self.pageControl sizeForNumberOfPages:imageGroup.count]];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (void)setCycleModel:(TJ_CycleScrollViewModel)cycleModel
{
    _cycleModel = cycleModel;
    [self setPageControllFrame:[self.pageControl sizeForNumberOfPages:self.imageGroup.count]];
}

#pragma mark Other

- (void)setTimer
{
    [_timer invalidate];
    _timer = nil;
    NSTimer *timer1 = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(scrollImageView) userInfo:nil repeats:YES];
    _timer = timer1;
}

- (void)setPageControllFrame:(CGSize)Size
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
            frame.origin.x = Size.width / 2 + 20;
            frame.origin.y = self.frame.size.height - 20;
            self.pageControl.frame = frame;
            break;
        }
        case TJ_CycleScrollViewPageControlStyleDownRight:
        {
            self.pageControl.frame = CGRectMake(
                                                selfWidth - Size.width - 20,
                                                selfHeight - 20,
                                                Size.width,
                                                Size.height
                                                );
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
//    NSLog(@"%f   %f",self.scrollView.contentSize.width, self.interval);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
