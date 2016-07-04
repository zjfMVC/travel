//
//  DetailView.h
//  Travel
//
//  Created by qf1 on 16/2/6.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "VideosDetailModel.h"
#import <UIKit/UIKit.h>

@interface DetailView : UIScrollView

@property (nonatomic,weak)id target;
@property (nonatomic,assign)SEL action;
// 详情模型
@property (nonatomic, strong) VideosDetailModel *videosDetailModel;

@property (nonatomic, strong) UIImageView *imageView;
// 开始按钮
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

- (void)setDataWithModel:(VideosDetailModel *)model target:(id)target action:(SEL)action;
@end
