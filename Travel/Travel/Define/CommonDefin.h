//
//  CommonDefin.h
//  Travel
//
//  Created by qf1 on 16/1/23.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import <UIKit/UIKit.h>
#ifndef Travel_CommonDefin_h
#define Travel_CommonDefin_h
/**
 *  颜色的宏
 *
 *  @param rgbValue 十六进制颜色
 *
 *  @return UIColor
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define UIColorFromRGBAlpha(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.0]
/**
 *  当前的App版本
 */
#define kAppVersion (1.0)


/**
 *  当前系统版本
 */
#define kSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])


/**
 *  当前屏幕大小
 */
#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height


/**
 *  第一次启动App的Key
 */
#define kAppFirstLoadKey @"kAppFirstLoadKey"

/**
 *  调试模式的标签
 */
#define DEBUG_FLAG  1


/**
 *  如果是调试模式，QFLog就和NSLog一样，如果不是调试模式，QFLog就什么都不做
 *  __VA_ARGS__ 表示见面...的参数列表
 */
#ifdef DEBUG_FLAG
#define QFLog(fmt, ...) NSLog(fmt, __VA_ARGS__)
#else
#define QFLog(fmt, ...)
#endif


#endif
