//
//  CenterViewController.m
//  Travel
//
//  Created by qf1 on 16/1/25.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "CenterViewController.h"

#import "UIColor+BackColor.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "ZJFTabBarController.h"

@interface CenterViewController ()

// 蒙层视图
@property (nonatomic, strong) UIView *makeView;
@end

@implementation CenterViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addPanGesture" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiderMakeView) name:@"hiderMakeView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMakeView) name:@"showMakeView" object:nil];
    
    self.view.backgroundColor = [UIColor getThemeColor];
    
    [self addTapGesture];
    [self setNav];
}

#pragma mark - 设置导航
- (void)setNav
{
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"TabBarIconMyNormal.png"] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(leftOnClick)];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor blackColor]];
    
    // 设置导航栏返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    self.navigationItem.backBarButtonItem = backItem;
    // 设置导航栏中颜色(例如字体，返回按钮)
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
}

#pragma mark - 按钮点击方法
-(void)leftOnClick
{
    
    AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //de.window 获得窗口
    //de.window.rootViewController 获得窗口的根视图控制器
    DrawerViewController *drawer = (DrawerViewController *)de.window.rootViewController;
    if (drawer.isShow) {
        //现在是展示左侧
        [drawer showCenterVc];
        
    } else {
        
        [drawer showLeftVc];
        
    }
    
}

- (void)backAction
{
    
}

#pragma mark - 给蒙版添加手势
-(void)addTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(tapAction:)];
    [self.makeView addGestureRecognizer:tap];
}

#pragma mark - 手势执行方法
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //de.window 获得窗口
    //de.window.rootViewController 获得窗口的根视图控制器
    DrawerViewController *drawer = (DrawerViewController *)de.window.rootViewController;
    if (drawer.isShow) {
        //现在时展示左侧
        [drawer showCenterVc];
    }else{
        [drawer showLeftVc];
        
    }
    
}

#pragma  mark 展示和隐藏蒙版
-(void)showMakeView
{
    [self.view addSubview:self.makeView];
    AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
    DrawerViewController *drawer = (DrawerViewController *)de.window.rootViewController;
    for (UIViewController *vc in drawer.childViewControllers) {
        if ([vc isKindOfClass:[ZJFTabBarController class]]) {
            // 把蒙层插到视图的最顶层，才能覆盖整个屏幕
            [vc.view insertSubview:self.makeView aboveSubview:vc.view];
        }
    }
}

-(void)hiderMakeView
{
    [self.makeView removeFromSuperview];
}

#pragma mark - 重写getter函数
-(UIView *)makeView
{
    if (_makeView == nil) {
        _makeView = [[UIView alloc] initWithFrame:self.view.bounds];
        _makeView.backgroundColor = [UIColor grayColor];
        _makeView.alpha = 0.2;
    }
    return _makeView;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hiderMakeView" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showMakeView" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end














