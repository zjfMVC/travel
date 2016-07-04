//
//  ActivityViewController.m
//  Travel
//
//  Created by qf1 on 16/1/24.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#define kSection 0.1
#import "ZJFDataModel.h"
#import "ZJFDataModel+Net.h"

#import "CateryViewController.h"
#import "ActivityViewController.h"
@interface ActivityViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZJFDataModel *dataModel;
@property (nonatomic, strong) MBProgressHUD *hud;//等待提示框

@end

@implementation ActivityViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 发送通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"removePanGesture" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiderMakeView" object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor getRandomColor];
    [self getData];
    [self createUI];

}

#pragma mark 下载数据相关
/**下拉刷新触发的方法*/
-(void)refeshData{
    
    [self getData];
}


#pragma mark - 获取数据
- (void)getData
{
    //添加子视图
    [self.view addSubview:self.hud];
    //显示
    [self.hud show:YES];
    
    [ZJFDataModel requestWithPage:nil compltionBlock:^(ZJFDataModel *dataModel, NSError *error) {
        
        //隐藏提示框
        [self.hud hide:YES];
        
        if (error == nil) {
            
//            NSLog(@"获取数据成功");
            
            self.dataModel = dataModel;
            
            [self.tableView reloadData];
            
            //停止刷新
            [self.tableView.header endRefreshing];
            
        } else {
            NSLog(@"获取数据失败");
        }
        
    }];

}


#pragma mark - 创建UI
- (void)createUI
{
    self.view.backgroundColor = [UIColor getThemeColor];
    self.title = @"精彩活动";
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = kScreenHeight * kSection;
    [self.view addSubview:self.tableView];
    
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refeshData];
    }];
    
}


#pragma mark - 表格代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataModel.data.navs.itemsList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cateryCell = @"cateryCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cateryCell];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cateryCell];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    
     ItemsList *itemsList = self.dataModel.data.navs.itemsList[indexPath.section];
     [cell.imageView sd_setImageWithURL:[NSURL URLWithString:itemsList.thumb]];
     cell.textLabel.text = itemsList.title;
     cell.detailTextLabel.text = itemsList.desc;
    
    return cell;
    
}

// 组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CateryViewController *cateryVc = [[CateryViewController alloc] init];
    ItemsList *itemsList = self.dataModel.data.navs.itemsList[indexPath.section];
    cateryVc.url = itemsList.url;
    cateryVc.title = itemsList.title;
    cateryVc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:cateryVc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 懒加载
-(MBProgressHUD *)hud{
    if (_hud == nil) {
        _hud = [[MBProgressHUD alloc]initWithView:self.view];
        //设置提示文字
        _hud.labelText = @"正在加载";
    }
    return _hud;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end













