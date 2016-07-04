//
//  MyViewController.h
//  Travel
//
//  Created by qf1 on 16/1/24.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController
@property (nonatomic, strong) UINavigationController *delegate;

@property (nonatomic, strong) NSArray <UINavigationController *>*delegateArr; // 存放每个页面导航囊控制器的数组
@end
