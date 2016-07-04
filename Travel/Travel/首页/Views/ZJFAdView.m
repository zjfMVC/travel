//
//  ZJFAdView.m
//  Travel
//
//  Created by qf1 on 16/1/26.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "ZJFAdView.h"

@interface ZJFAdView ()<UIScrollViewDelegate>
{
    // 记录定时器对象
    NSTimer *_timer;
}

@end


@implementation ZJFAdView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
    }
    return self;
}


- (void)reloadAdViewData
{
    for (UIView *view in self.subviews) {
        // 从父view中删除
        [view removeFromSuperview];
    }
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    NSInteger count = 0;
    // 如果实现了，那么就调用此方法得到count
    if ([self.adDataSourec respondsToSelector:@selector(numberAdDatasForAdView:)]) {
        
        count = [self.adDataSourec numberAdDatasForAdView:self];
        
    }
    
    for (NSInteger i=0; i<count; i++) {
        
        // 获取image url
        // respondsToSelector: 看这个 adDataSource 是否实现
        if ([self.adDataSourec respondsToSelector:@selector(adView:imageUrlAtIndex:)]) {
            
            NSString *imageUrl = [self.adDataSourec adView:self imageUrlAtIndex:i];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*w, 0, w, h)];
            imageView.tag = i + 100;
            imageView.userInteractionEnabled = YES;
            // 添加手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [imageView addGestureRecognizer:tap];
            // 请求网络数据
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
            [self addSubview:imageView];
            
        }
    }
    
    self.contentSize = CGSizeMake(count*self.frame.size.width, self.frame.size.height);
    self.pagingEnabled = YES;
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, h - 20, w, 20)];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    _pageControl.numberOfPages = count;
    _pageControl.currentPage = 0;
    
    if ([self.adDataSourec respondsToSelector:@selector(addPageControl:)]) {
        
        [self.adDataSourec addPageControl:self.pageControl];
    }
    
    [self createTimer];
}


#pragma mark - 手势执行方法
/**
 *  手势执行方法
 *
 *  @param tap 手势
 */
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    
    NSInteger index = imageView.tag - 100;
    
    if ([self.adDataSourec respondsToSelector:@selector(didSelectImageAtIndex:)]) {
        
        [self.adDataSourec didSelectImageAtIndex:index];
    }
    
}
// 销毁定时器
- (void)dealloc
{
    [self stopTimer];
}

// 创建定时器
- (void)createTimer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        //给定时器分流主线程时间（提高定时器的优先级）
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}
// 停止定时器
- (void)stopTimer
{
    //停止定时器(一旦停止，就不能再使用，再用的时候需要重新创建)
    [_timer invalidate];
    _timer = nil;
}
// 定时器执行方法
- (void)timerAction
{
    // 设置偏移
    CGFloat x = self.contentOffset.x;
    CGFloat w = self.frame.size.width;
    // 还没滚动到最后一张
    if ((x+w)<self.contentSize.width) {
        
        x += w;
        [self setContentOffset:CGPointMake(x, self.contentOffset.y) animated:YES];
        int page = self.contentOffset.x/self.frame.size.width;
        _pageControl.currentPage = page;
        
    } else {
        // 回到第一张
        [self setContentOffset:CGPointMake(0, self.contentOffset.y) animated:NO];
        _pageControl.currentPage = 0;
    }
    
}


#pragma mark -滚动视图的代理
/**
 *  当正在滚动的时候调用，不根据手势来判断
 *
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/self.bounds.size.width;
//    int currentPage = _pageControl.currentPage;
    if (_pageControl.currentPage == page) {
        return;
    } else {
        _pageControl.currentPage = page;
    }
    
}
/**
 *  开始拖拽的时候调用
 *
 *  @param scrollView scrollView description
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //移除定时器
    [self stopTimer];

}
/**
 *  停止拖拽的时候调用
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //开启定时器
    [self createTimer];
    
}


@end








