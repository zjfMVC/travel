//
//  DrawerViewController.h
//  Travel
//
//  Created by qf1 on 16/1/24.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerViewController : UIViewController
// 记录当前的显示状态，NO为显示中心视图(HomeViewController中的view),YES为显示左侧视图(MyViewController中的view)
@property (nonatomic, assign)BOOL isShow;

-(void)showLeftVc;

-(void)showCenterVc;

-(id)initWithLeftVc:(UIViewController *)leftVc centerVc:(UIViewController *)centerVc;

@end
