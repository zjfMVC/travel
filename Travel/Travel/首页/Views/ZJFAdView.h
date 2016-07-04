//
//  ZJFAdView.h
//  Travel
//
//  Created by qf1 on 16/1/26.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJFAdView;
// 用协议实现封装
@protocol ZJFAdViewDataSource <NSObject>
@required
// 告诉delegateyou多少条广告
- (NSInteger)numberAdDatasForAdView:(ZJFAdView *)adView;
// 告诉广告视图在第n个广告的图片url
- (NSString *)adView:(ZJFAdView *)adView imageUrlAtIndex:(NSInteger)index;
// 设置UIPageControl
@optional
- (void)addPageControl:(UIPageControl *)pageControl;

- (void)didSelectImageAtIndex:(NSInteger)index;
@end

@interface ZJFAdView : UIScrollView
// 代理属性
@property (nonatomic, weak) id<ZJFAdViewDataSource> adDataSourec;
@property (nonatomic, strong) UIPageControl *pageControl;
// 刷新广告栏方法
- (void)reloadAdViewData;

@end













