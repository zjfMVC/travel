//
//  TableHeaderView.m
//  Travel
//
//  Created by qf1 on 16/1/29.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#define kScale 0.02
#import "TableHeaderView.h"

@interface TableHeaderView ()

@end
@implementation TableHeaderView

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
    self.backgroundColor = [UIColor whiteColor];
   
    // x左侧距离
    CGFloat marginX = 5;
//    // y方向距离
//    CGFloat marginY = 2;
    CGFloat x = self.frame.origin.x + marginX;
    CGFloat y = self.frame.origin.y;
    CGFloat w = self.frame.size.width * kScale;
    CGFloat h = self.frame.size.height;
    _leftView = [[UIView alloc] initWithFrame:CGRectMake(x , y, w, h)];
    _leftView.backgroundColor = [UIColor redColor];
    _leftView.layer.masksToBounds = YES;
    _leftView.layer.cornerRadius = 5.0/2.0;
    [self addSubview:_leftView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftView.frame), y, 100, h)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = [UIColor blackColor];
    [self addSubview:_titleLabel];

}

// 设置标题
- (void)setTitleLabelWithArray:(NSArray *)array Section:(NSInteger)section
{
    _titleLabel.text = array[section];
}


@end






















