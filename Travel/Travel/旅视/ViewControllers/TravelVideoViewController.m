//
//  TravelVideoViewController.m
//  Travel
//
//  Created by qf1 on 16/1/24.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
// 组头高度比例
#define kHeadScale 0.05
// 分类按钮的缩放比例
#define kHeaderView 0.25
// cell的缩放比例
#define kVideosScale 0.3
#import "ZJFVideosModel.h"
#import "ZJFVideosModel+Net.h"
#import "VideosCell.h"

#import "VideosHeaderView.h"
#import "VideosDetailViewController.h"
#import "TravelVideoViewController.h"
@interface TravelVideoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) MBProgressHUD *hud;
//当前加载页码
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSString *titleText;

@end

@implementation TravelVideoViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 发送通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"removePanGesture" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiderMakeView" object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refeshData];
    [self createUI];
    
}


#pragma mark 上下拉刷新
/**下拉刷新触发的方法*/
-(void)refeshData{
    _currentPage = 0;
    _titleText = @"精彩推荐";
    [self getData];
}
/**上拉加载触发触发的方法*/
-(void)loadMoreData{
    _currentPage++;
    _titleText = @"精彩推荐";
    [self getData];
}


#pragma mark - 获取数据
- (void)getData
{
    //添加子视图
    [self.view addSubview:self.hud];
    //显示
    [self.hud show:YES];
    
    [ZJFVideosModel requestVideosWithPage:_currentPage compltionBlock:^(NSMutableArray *array, NSError *error) {
        
        [self.hud hide:YES];
        
        if (error == nil) {
          
            if (_currentPage == 0) {
                //如果是下拉刷新，则清空数组
                [self.dataSource removeAllObjects];
            }
            
            [self.dataSource addObjectsFromArray:array];
            [self.tabelView reloadData];
            
            //停止刷新
            [self.tabelView.header endRefreshing];
            [self.tabelView.footer endRefreshing];
            
//            NSLog(@"旅视获取数据成功");
        } else {
            NSLog(@"%@",error.description);
        }
        
    }];
    
}


#pragma mark - 创建UI
- (void)createUI
{
    self.view.backgroundColor = [UIColor getThemeColor];
    // 设置导航栏
    self.navigationItem.title = @"精彩世界";
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    // 表头视图
    VideosHeaderView *headerView = [[VideosHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * kHeaderView)];
    // 添加点击事件
    [headerView addButtonEventWithTarget:self action:@selector(refeshTabelViewWithTags:)];
    // 设置表格
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.rowHeight = kScreenHeight * kVideosScale;
    _tabelView.tableHeaderView = headerView;
    [self.view addSubview:_tabelView];
    // 注册表格
    [_tabelView registerClass:[VideosCell class] forCellReuseIdentifier:@"videosCell"];
    
    //下拉刷新
    self.tabelView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refeshData];
    }];
    
    //上拉加载
    self.tabelView.footer =  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];

}


#pragma mark - 表格代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videosCell" forIndexPath:indexPath];
    
    cell.contenModel = self.dataSource[indexPath.row];
    
    return cell;
}

// 组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kScreenHeight * kHeadScale;
}

// 设置组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = _titleText;
    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    _titleLabel.backgroundColor = [UIColor lightGrayColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return _titleLabel;
}

// 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentModel *contentModel = self.dataSource[indexPath.row];
    VideosDetailViewController *detailVc = [[VideosDetailViewController alloc] init];
    detailVc.url = contentModel.links[@"self"];
    detailVc.navigationItem.title = contentModel.tags;
    detailVc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailVc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 点击事件
- (void)refeshTabelViewWithTags:(NSString *)tags
{
    _titleText = tags;
    [ZJFVideosModel requestVideosWithTags:tags compltionBlock:^(NSMutableArray *array, NSError *error) {
        
        if (error == nil) {
            
            [self.dataSource removeAllObjects];
            
            [self.dataSource addObjectsFromArray:array];
            // 刷新某一分组
            NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:0];
            [self.tabelView reloadSections:indexset withRowAnimation:UITableViewRowAnimationLeft];

            [self.tabelView.header endRefreshing];
            [self.tabelView.footer endRefreshing];
        } else {
            
            NSLog(@"获取数据失败");
        }
        
    }];
    
}


#pragma mark - 懒加载 重写geetter方法
-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

-(MBProgressHUD *)hud
{
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


































