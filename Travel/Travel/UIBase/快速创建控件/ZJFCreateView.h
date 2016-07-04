//
//  ZJFCreateView.h
//  工具类
//
//  Created by qf1 on 16/1/7.
//  Copyright © 2016年 qf1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJFCreateView : UIView

+ (UIButton *)createSystemButtonWithFrame:(CGRect )frame title:(NSString *)title imageName:(NSString *)imageName backImageName:(NSString *)backImageName target:(id)target action:(SEL)action;

// 创建Label
+ (UILabel *)createLabelWithFrame:(CGRect )frame text:(NSString *)text textColor:(UIColor *)textColor;

// 创建imageView
+ (UIImageView *)createImageViewWithFrame:(CGRect )frame image:(UIImage *)image;

@end
