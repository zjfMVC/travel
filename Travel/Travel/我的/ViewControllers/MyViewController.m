//
//  MyViewController.m
//  Travel
//
//  Created by qf1 on 16/1/24.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#define kScale 0.25
#define kHeadScale 0.25
#import "CollectionViewController.h"
#import "DetailModel.h"
#import "MyViewController.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showMakeView" object:nil];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initArray];
    [self createUI];
    
}

#pragma mark - 创建UI
- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth * kScale, kScreenHeight * kHeadScale, self.view.frame.size.width, kScreenHeight * (1 - kHeadScale)) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;

    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}


#pragma mark - 表格代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor clearColor];

//    if (indexPath.section == 2) {
//        // 计算图片缓存
//        float fileSize = [[SDImageCache sharedImageCache] getSize] / (1024 * 1024);
//        cell.textLabel.text = [NSString stringWithFormat:@"%@(%0.2fM)",self.dataSource[indexPath.section],fileSize];
//        
//    } else {
//        cell.textLabel.text = self.dataSource[indexPath.section];
//    }
    cell.textLabel.text = self.dataSource[indexPath.section];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",self.dataSource[indexPath.section]]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        CollectionViewController *collectionVc = [[CollectionViewController alloc] init];
        collectionVc.hidesBottomBarWhenPushed = YES;
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:collectionVc];
        [self presentViewController:na animated:YES completion:nil];
        
    } else if (indexPath.section == 2) {
        
        float fileS = [[SDImageCache sharedImageCache] getSize] / (1024 * 1024);
        
        if (fileS == 0) {
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"亲,目前还没有图片缓存呢,先去浏览浏览吧" message:nil delegate:self cancelButtonTitle:@"嗯嗯.." otherButtonTitles:nil];
            [alertView show];
            return ;
            
        }
        else{
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"成功清除%0.2fM的图片缓存!",fileS] message:nil delegate:self cancelButtonTitle:@"嗯嗯.." otherButtonTitles:nil];
                
                [self.tableView reloadData];
                [alertView show];
                return ;
            }];
            
        }
 
    } else if (indexPath.section == 1) {
        
        //集成新浪微博，微信和QQ
        [UMSocialSnsService presentSnsIconSheetView:self appKey:@"53f5a6a6fd98c50d6b0029d3" shareText:@"旅游达人" shareImage:[UIImage imageNamed:@""] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQzone,UMShareToRenren,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,nil] delegate:nil];
        
    } else if (indexPath.section == 3) {
        
        // 反馈
        [UMFeedback showFeedback:self withAppkey:@"53f5a6a6fd98c50d6b0029d3"];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 初始化
- (void)initArray
{
    _dataSource = @[@"我的收藏",@"我的分享",@"清除缓存",@"问题反馈",@"偏好设置"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end























