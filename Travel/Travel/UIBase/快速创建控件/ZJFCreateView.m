//
//  ZJFCreateView.m
//  工具类
//
//  Created by qf1 on 16/1/7.
//  Copyright © 2016年 qf1. All rights reserved.
//

#import "ZJFCreateView.h"

@implementation ZJFCreateView

// 创建按钮
+ (UIButton *)createSystemButtonWithFrame:(CGRect )frame title:(NSString *)title imageName:(NSString *)imageName backImageName:(NSString *)backImageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

// 创建Label
+ (UILabel *)createLabelWithFrame:(CGRect )frame text:(NSString *)text textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    return label;
}

// 创建imageView
+ (UIImageView *)createImageViewWithFrame:(CGRect )frame image:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    return imageView;
}



@end











