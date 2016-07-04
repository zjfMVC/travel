//
//  AdView.m
//  Travel
//
//  Created by qf1 on 16/1/24.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#define  WIDTH self.frame.size.width
#define  HEIGHT self.frame.size.height
#import "AdView.h"

@interface AdView ()<UIScrollViewDelegate>
{
    NSInteger _currentPage;//记录当前的显示页
 
}

@property (nonatomic, copy) GoBackBlock goBlock;

@end

@implementation AdView
// 初始化方法
-(id)initWithArray:(NSArray *)array  andFrame:(CGRect)frame andBlock:(GoBackBlock)back
{
    if (self = [super init]) {
        
        self.frame  = frame;
        NSMutableArray *ra = [NSMutableArray arrayWithArray:array];
        NSString *s0 = array[0];
        NSString *tailS = array[array.count - 1];
        [ra insertObject:tailS atIndex:0 ];
        [ra addObject:s0];
        self.imageArray = [NSArray arrayWithArray:ra];
        [self createUI];
        // 保证生命周期
        self.goBlock = back;
        
    }
    return self;
}

#pragma mark - 创建UI
- (void)createUI
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    scrollView.backgroundColor = [UIColor yellowColor];
    //创建滚动视图的子视图
    NSArray *imageArray = self.imageArray;
    
    for (int i = 0; i < imageArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*WIDTH, 0, WIDTH,HEIGHT )];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        imageView.backgroundColor = [UIColor blackColor];
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        
        if (i == imageArray.count-2) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
            [button addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor clearColor];
            
            [imageView addSubview:button];
            
        }
    }
    
    //设置内容视图的大小
    scrollView.contentSize = CGSizeMake(imageArray.count*WIDTH, HEIGHT);
    //用户看到的第一张
    scrollView.contentOffset = CGPointMake(WIDTH, 0);
    //设置回弹效果
    scrollView.bounces = NO;
    //设置代理
    scrollView.delegate = self;
    //翻页效果
    scrollView.pagingEnabled = YES;
    //设置水平的指示条
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    
    UIPageControl *page = [[UIPageControl alloc]initWithFrame:CGRectMake(250, 250, 100, 50 )];
    page.numberOfPages = imageArray.count -2;
    page.pageIndicatorTintColor  = [UIColor yellowColor];
    page.currentPageIndicatorTintColor = [UIColor whiteColor];
    _currentPage = 1;
    //设置页码指示器的页码
    page.currentPage = _currentPage-1;
    page.tag = 20;
    //    [self addSubview:page];
}

#pragma mark - 按钮执行方法
-(void)go
{
    self.goBlock();
    
}


#pragma mark - UIScrollView代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    //获取偏移量
    CGPoint point = scrollView.contentOffset;
    if (point.x == 0) {
        scrollView.contentOffset = CGPointMake(WIDTH*(self.imageArray.count-2), 0);
        
    }
    if (point.x == WIDTH*(self.imageArray.count-1)) {
        scrollView.contentOffset = CGPointMake(WIDTH, 0);
    }
    //获得页码指示器
    UIPageControl *page = (UIPageControl *)[self viewWithTag:20];
    _currentPage = scrollView.contentOffset.x/WIDTH;
    NSLog(@"_currentPage %ld",_currentPage);
    page.currentPage = _currentPage-1;
    
}


@end










