//
//  FreeWalkerViewController.m
//  Travel
//
//  Created by qf1 on 16/1/24.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#define kHeaderViewScale 0.1
#define kCellScale 0.35

#import "FreeWalkModel.h"
#import "FreeWalkModel+Net.h"

#import "FreeWalkCell.h"
#import "FreeWalkHeaderView.h"

#import "FreeWalkListViewController.h"
#import "FreeWalkerViewController.h"
@interface FreeWalkerViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation FreeWalkerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 发送通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"removePanGesture" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiderMakeView" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getData];
    [self createUI];
}

#pragma mark 上下拉刷新
/**下拉刷新触发的方法*/
-(void)refeshData{
    _currentPage = 1;
    [self getData];
}
/**上拉加载触发触发的方法*/
-(void)loadMoreData{
    _currentPage++;
    [self getData];
}


#pragma mark - 获取数据
- (void)getData
{
    //添加子视图
   [self.view addSubview:self.hud];
    //显示
   [self.hud show:YES];
    
   [FreeWalkModel requestFreeWalkWithPage:_currentPage compltionBlock:^(NSMutableArray *array, NSError *error) {
       
       [self.hud hide:YES];
       
       if (error == nil) {
           
           if (_currentPage == 1) {
               //如果是下拉刷新，则清空数组
               [self.dataSource removeAllObjects];
           }
           
           [self.dataSource addObjectsFromArray:array];
           [self.collectionView reloadData];
           
           //停止刷新
           [self.collectionView.header endRefreshing];
           [self.collectionView.footer endRefreshing];
           
//           NSLog(@"自由行获取数据成功");
       } else {
           NSLog(@"自由行获取数据失败");
       }
       
       
   }];
}


#pragma mark - 创建UI
- (void)createUI
{
    self.view.backgroundColor = [UIColor getThemeColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[FreeWalkCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //下拉刷新
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refeshData];
    }];
    
    //上拉加载
    self.collectionView.footer =  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    [_collectionView registerClass:[FreeWalkHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}


#pragma mark UICollectionView代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FreeWalkCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.freeWalkModel = self.dataSource[indexPath.item];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //设置cell的大小
    return CGSizeMake((kScreenWidth-6)/2, kScreenHeight * kCellScale);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    //设置和collectionView滑动方向不一致的方向的最小间隔
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    //设置和collectionView滑动方向一致的方向的间隔
    return 2;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //设置分组四周的间距
    return UIEdgeInsetsMake(2, 2, 0, 2);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FreeWalkListViewController *freeWalkListVc = [[FreeWalkListViewController alloc] init];
    FreeWalkModel *freeWalkModel = self.dataSource[indexPath.item];
    freeWalkListVc.webViewUrl = freeWalkModel.url;
    freeWalkListVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:freeWalkListVc animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //和cell一样，段头段尾都有复用机制
    FreeWalkHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    [headerView setLabelTextWithArray:@[@"精选产品",@"更懂你——精挑细选属于你的世界"]];
    return headerView;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    //设置段头的大小,如果滑动方向是纵向，宽度设置无效
    return CGSizeMake(0, kScreenHeight * kHeaderViewScale);
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






























