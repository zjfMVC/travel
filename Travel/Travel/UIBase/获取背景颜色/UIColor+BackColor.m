//
//  UIColor+BackColor.m
//  Travel
//
//  Created by qf1 on 16/1/24.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "UIColor+BackColor.h"

@implementation UIColor (BackColor)

// 获得随机的颜色
+(UIColor *)getRandomColor
{
    UIColor *randColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1];
    return randColor;

}

// 获得主题颜色
+(UIColor *)getThemeColor
{
    UIColor *themeColor = [UIColor blueColor];
    return themeColor;
}

@end




