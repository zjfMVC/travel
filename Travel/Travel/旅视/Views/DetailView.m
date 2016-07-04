//
//  DetailView.m
//  Travel
//
//  Created by qf1 on 16/2/6.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#define kShareButton 0.1
// startImageView缩放比例
#define kStartImageView 0.2
// imageView缩放比例
#define kImage 0.5
#import "DetailView.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation DetailView

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
    // 高度根据数据内容来计算
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:17];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = [UIColor grayColor];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.userInteractionEnabled = YES;
    
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _startButton.tag = 100;
    _startButton.alpha = 0.5;
    [_startButton setBackgroundImage:[UIImage imageNamed:@"10.png"] forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareButton.tag = 101;
    [_shareButton setBackgroundImage:[UIImage imageNamed:@"share_icon.png"] forState:UIControlStateNormal];
    [_shareButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    [_imageView addSubview:_shareButton];
    [_imageView addSubview:_startButton];
    [self addSubview:_titleLabel];
    [self addSubview:_contentLabel];
    [self addSubview:_imageView];
    
}


#pragma mark - 设置数据
- (void)setDataWithModel:(VideosDetailModel *)model target:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
    self.videosDetailModel = model;
    // _imageView的宽高
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height * kImage;
    // y方向的间隙
    CGFloat marginY = 5;
    // x方向的间隙
    CGFloat marginX = 5;
    NSString *titleStr = model.name;
    NSString *contentStr = model.intro;
    // 高度根据数据内容来计算
    CGRect titleRect = [titleStr boundingRectWithSize:CGSizeMake(w - marginX * 2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:20]} context:nil];
    
    CGRect contentRect = [contentStr boundingRectWithSize:CGSizeMake(w - marginX * 2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:17]} context:nil];
    
    _titleLabel.frame = CGRectMake(marginX, marginY, w - marginX * 2, titleRect.size.height);
    
    _imageView.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame) + marginY, w, h);

    _contentLabel.frame = CGRectMake(marginX, CGRectGetMaxY(_imageView.frame) + marginY * 2, w - marginX * 2, contentRect.size.height);
    
    _startButton.frame = CGRectMake((w - w * kStartImageView)/2, (h - w * kStartImageView)/2, w * kStartImageView, w * kStartImageView);
    
    _shareButton.frame = CGRectMake(0, 0, w * kShareButton , h * kShareButton);
    

    // 设置属性
    _titleLabel.text = titleStr;
    _contentLabel.text = contentStr;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.imageHref] placeholderImage:[UIImage imageNamed:@""]];
    
    // 计算滚动视图包含内容大小
    self.contentSize = CGSizeMake(self.frame.size.width, CGRectGetMaxY(_contentLabel.frame));

}

#pragma mark - 按钮点击事件
- (void)buttonAction:(UIButton *)button
{
    NSInteger tag = button.tag;
    NSNumber *num = [NSNumber numberWithInteger:tag];
    if ([self.target respondsToSelector:self.action]) {
        
        [self.target performSelector:self.action withObject:_videosDetailModel withObject:num];
    }
    
}



@end


















