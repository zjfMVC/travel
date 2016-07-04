//
//  VideosHeaderView.m
//  Travel
//
//  Created by qf1 on 16/2/5.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "UIColor+BackColor.h"
#import "VideosHeaderView.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation VideosHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        [self createUI];
    }
    return self;
}


#pragma mark - 创建UI
- (void)createUI
{
    NSArray *titleArray = @[@"爱自驾",@"玩户外",@"度周末",@"亲子游",@"城会玩",@"看世界"];
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图.png"]];
    
    // x左侧距离
    CGFloat marginX = 5;
    // y方向距离
    CGFloat marginY = 5;
    CGFloat w = (self.frame.size.width - marginX * 4)/3;
    CGFloat h = (self.frame.size.height - marginY * 3)/2;
    
    for (int i=0; i<titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor clearColor];
        button.frame = CGRectMake(i%3 * w + marginX * (i%3 + 1), i/3 * h + marginY * (i/3 + 1), w, h);
        
        [button setBackgroundImage:[UIImage imageNamed:@"user_background.png"] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor getRandomColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
    }
    
}


#pragma mark - 记录事件和执行对象
- (void)addButtonEventWithTarget:(id)target action:(SEL)action;
{
    self.target = target;
    self.action = action;
}


#pragma mark - 按钮点击事件
- (void)buttonAction:(UIButton *)button
{
    if ([self.target respondsToSelector:self.action]) {
        
        [self.target performSelector:self.action withObject:button.titleLabel.text];
    }
}

@end



















