//
//  ViewController.m
//  Travel
//
//  Created by qf1 on 16/1/23.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "ViewController.h"
#import "ZJFTabBarController.h"
#import "DrawerViewController.h"
#import "MyViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor  = [UIColor getRandomColor];

    //判断是否是第一次登陆，是就展示用户的引导图，不是就进入主界面
    if ([self isFisrtStarApp] == YES) {
        //第一次启动
        [self showGuideView];
        
    } else {
        
        [self goHomeView];
    }
    
}

#pragma mark - 进入引导页
- (void)showGuideView
{
    NSArray *imageArray = @[@"helpphoto_one",@"helpphoto_two",@"helpphoto_three",@"helpphoto_four",@"helpphoto_five"];

    // 回调的block
    AdView *adView = [[AdView alloc]initWithArray:imageArray andFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight) andBlock:^{
        
        [self goHomeView];
        
    }];
    
    [self.view addSubview:adView];
}

#pragma mark - 进入主页
- (void)goHomeView
{
    ZJFTabBarController *tabBar = [[ZJFTabBarController alloc] init];

    // 系统默认半透明打开
//    tabBar.tabBar.translucent = NO;
    [tabBar.tabBar setBackgroundColor:[UIColor greenColor]];
    
    UINavigationController *homeNa = [self createNavItemsWithClass:[HomeViewController class] title:@"首页" image:@"TabBarIconFeaturedNormal.png" selectedImage:@"TabBarIconFeatured.png"];
    
    UINavigationController *travelVideoNa = [self createNavItemsWithClass:[TravelVideoViewController class] title:@"旅视" image:@"zipai_focus.png" selectedImage:@"zipai_normal.png"];
    
    UINavigationController *actionNa = [self createNavItemsWithClass:[ActivityViewController class] title:@"活动" image:@"TabBarIconToolboxNormal.png" selectedImage:@"TabBarIconToolbox.png"];
    
    UINavigationController *freedNa = [self createNavItemsWithClass:[FreeWalkerViewController class] title:@"自由行" image:@"zijia_focus.png" selectedImage:@"zijia_normal.png"];
    
    MyViewController *myVc = [[MyViewController alloc] init];
    
    
    myVc.delegate = homeNa; // 待解决每个页面跳转问题
    
    tabBar.viewControllers = @[homeNa,travelVideoNa,actionNa,freedNa];
    //获得窗口，更改根视图控制器
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    // DrawerViewController作为最根的视图控制器，实现抽屉效果
    DrawerViewController *drawerVc = [[DrawerViewController alloc] initWithLeftVc:myVc centerVc:tabBar];
    
    appDelegate.window.rootViewController = drawerVc;
    
}

// 创建导航控制器
-(UINavigationController*) createNavItemsWithClass:(Class)class title:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selImage
{
    // 生成一个view controller，把它放到导航控制器中
    UIViewController* Vc = (UIViewController*)[[class alloc] init ];
    
    Vc.tabBarItem.title = title;
    // image对象生成的时候需要用imageWithRenderingMode：这个方法来指定生成出来的image对象是原本设计出来的效果
    Vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    Vc.tabBarItem.image = [UIImage imageNamed:image];
//    Vc.tabBarItem.selectedImage = [UIImage imageNamed:selImage];
    // 生成导航控制器
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController: Vc];
    // 修改导航栏整体的分格
    [[UINavigationBar appearance] setBackgroundColor:[UIColor blueColor]];
    // 导航栏背景图
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarShadow.png"] forBarMetrics:UIBarMetricsDefault];
    
    nav.navigationBar.translucent = NO;
    return nav;
}


#pragma mark - 判断是否第一次启动程序
-(BOOL)isFisrtStarApp
{
    //获得单例
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //读取次数（用户上一次启动app的次数）
    NSString *number = [userDefaults objectForKey:kAppFirstLoadKey];
    //判断是否有值
    if (number!=nil) {
        //能够取到值，则不是第一次启动
        NSInteger starNumer = [number integerValue];
        //用上一次的次数+1次
        NSString *str = [NSString stringWithFormat:@"%zd",++starNumer];
        //存的是用户这一次启动的次数
        [userDefaults setObject:str forKey:kAppFirstLoadKey];
        [userDefaults synchronize];
        return NO;
    }else{
        //不能取到值，则是第一次启动
        NSLog(@"用户是第一次启动");
        [userDefaults setObject:@"1" forKey:kAppFirstLoadKey];
        [userDefaults synchronize];
        return YES;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



















