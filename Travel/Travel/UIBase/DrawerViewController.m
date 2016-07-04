//
//  DrawerViewController.m
//  Travel
//
//  Created by qf1 on 16/1/24.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
// 缩放比例
#define kScale 0.25

#define kScreenWith  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

#import "DrawerViewController.h"
// 相当于左视图控制器
#import "MyViewController.h"
#import "HomeViewController.h"

@interface DrawerViewController ()
//@property (nonatomic,strong) UINavigationController *

@property (nonatomic,strong) UIViewController *leftVc;
@property (nonatomic,strong) UIViewController *centerVc;
@property (nonatomic,strong) UIGestureRecognizer *panGesture;

@property (nonatomic,assign) CGRect leftFrame;//记录的是初始位置的frame
@property (nonatomic,assign) CGRect centerFrame;//记录的是初始位置的frame

@property (nonatomic,assign) BOOL isMove;//判断是否可以左滑
@property (nonatomic,assign) BOOL isRight;

@end

@implementation DrawerViewController
// 重写构成方法
-(id)initWithLeftVc:(UIViewController *)leftVc centerVc:(UIViewController *)centerVc
{
    if (self = [super init]) {
        
        // 注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removePanGesture) name:@"removePanGesture" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addPanGesture) name:@"addPanGesture" object:nil];
        
        _isShow = NO;
        _isMove = YES;
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        // 保证生命周期，方便其他函数调用
        self.leftVc = leftVc;
        self.centerVc = centerVc;
        
        // 把self作为一个视图控制器的容器，管理其他的视图控制器
        [self addChildViewController:leftVc];
        [self addChildViewController:centerVc];
        
        // 设置view的frame
        self.leftVc.view.frame = CGRectMake(-kScreenWith, 0, kScreenWith, kScreenHeight );
        self.centerVc.view.frame = CGRectMake(0, 0, kScreenWith, kScreenHeight);
        
        // 添加子视图
        [self.view addSubview:self.leftVc.view];
        [self.view addSubview:self.centerVc.view];
        
        // 添加移动手势
        _panGesture = [[UIPanGestureRecognizer alloc]init];
        [_panGesture addTarget:self action:@selector(pan:)];
//        [self.view addGestureRecognizer:_panGesture];
        
        
    }
    return self;
    
}


#pragma mark - 移除移动手势
- (void)removePanGesture
{
    [self.view removeGestureRecognizer:_panGesture];
}

#pragma mark - 添加手势
- (void)addPanGesture
{
    [self.view addGestureRecognizer:_panGesture];
}

#pragma mark - 移动手势执行方法
-(void)pan:(UIPanGestureRecognizer *)pan
{
    //偏移量 相对于当前视图控制器的视图的坐标
    CGPoint point = [pan translationInView:self.view];
    //pan.state 手势的状态
    switch (pan.state) {
            //开始,一次
        case UIGestureRecognizerStateBegan:{
            _leftFrame = self.leftVc.view.frame;
            _centerFrame = self.centerVc.view.frame;
        }break;
            //移动，多次
        case UIGestureRecognizerStateChanged:{
        
            if (_isMove || point.x > 0) {// 防止左滑

                self.leftVc.view.frame = CGRectMake(_leftFrame.origin.x+point.x/2, 0, kScreenWith, kScreenHeight);
                self.centerVc.view.frame = CGRectMake(_centerFrame.origin.x+point.x, 0, kScreenWith, kScreenHeight);
                
            }
        }break;
            //结束，一次
        case UIGestureRecognizerStateEnded:{
            // 判定侧滑多少距离显示不同的Vc
            if (self.centerVc.view.frame.origin.x > kScreenWith/2) {
                [self showLeftVc];
            }else{
                [self showCenterVc];
            }
            
        }break;
        default:
            break;
    }
    
}


#pragma mark - 展示中间视图控制器tabBar
-(void)showCenterVc
{
    //参数一：动画的持续时间
    //参数二：动画的结束的值
    [UIView animateWithDuration:0.1 animations:^{
        self.centerVc.view.frame = CGRectMake(0, 0, kScreenWith, kScreenHeight);
        self.leftVc.view.frame = CGRectMake(-kScreenWith, 0, kScreenWith, kScreenHeight);
    }];
    
    _isShow = NO;
    _isMove = NO;
    // 通过ceneterVC获得HomeViewController 隐藏蒙版
    UITabBarController *centerTabBar = (UITabBarController *)self.centerVc;
    NSArray *array = centerTabBar.viewControllers;
    
    for (UINavigationController *centerNa in array) {
        
        CenterViewController *centerVc = (CenterViewController *)[centerNa.viewControllers lastObject];
        // 防止其他Vc进入调用不存在的方法，造成崩溃
        if ([centerVc isKindOfClass:[CenterViewController class]]) {
            [centerVc hiderMakeView];
        }
    }

}

#pragma mark - 展示左侧视图
-(void)showLeftVc
{
    [UIView animateWithDuration:0.1 animations:^{
        self.centerVc.view.frame = CGRectMake(kScreenWith * (1 - kScale), 0, kScreenWith, kScreenHeight);
        self.leftVc.view.frame = CGRectMake(kScreenWith * (1 - kScale) - kScreenWith, 0, kScreenWith, kScreenHeight);
    }];
    
    _isShow = YES;
    _isMove = YES;
    // 通过ceneterVC获得HomeViewController 展示蒙版
    UITabBarController *centerTabBar = (UITabBarController *)self.centerVc;
    NSArray *array = centerTabBar.viewControllers;
    
    for (UINavigationController *centerNa in array) {
        
        CenterViewController *centerVc = (CenterViewController *)[centerNa.viewControllers lastObject];
        if ([centerVc isKindOfClass:[CenterViewController class]]) {
            [centerVc showMakeView];
        }
    }
    
}

// 销毁通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"removePanGesture" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addPanGesture" object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end












