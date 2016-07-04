//
//  HomeViewController.m
//  Travel
//
//  Created by qf1 on 16/1/24.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
// 组头高度比例
#define kHeadScale 0.05
// 分类cell的缩放比例
#define kCateryScale 0.25
// cell的缩放比例
#define kScale 0.5
#import "ZJFDataModel.h"
#import "ZJFDataModel+Net.h"
#import "ZJFAdView.h"
#import "FlashModel.h"
#import "ZJFCateryCell.h"
#import "ZJFSpecialCell.h"
#import "ZJFCnListCell.h"

#import "PhotosViewController.h"
#import "CateryViewController.h"
#import "TableHeaderView.h"
#import "DetailViewController.h"
#import "HomeViewController.h"
#import "UIColor+BackColor.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,ZJFAdViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZJFAdView *adView;

@property (nonatomic, strong) ZJFDataModel *dataModel;
@property (nonatomic, strong) NSMutableArray *adViewArray;
@property (nonatomic, strong) NSMutableArray *searchArray;
@property (nonatomic, strong) NSMutableArray *cnListArray;


@property (nonatomic, strong) MBProgressHUD *hud;//等待提示框
@property (nonatomic, strong) UISearchController *searchController;//搜索
@property (nonatomic, strong) IQKeyboardReturnKeyHandler  *returnKeyHandler;

@property (nonatomic, assign) BOOL isRefesh;

@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiderMakeView" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    [self getData];
    [self createUI];
    
}



#pragma mark - 创建UI
- (void)createUI
{
    self.adView = [[ZJFAdView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * kCateryScale)];
    self.adView.adDataSourec = self;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableHeaderView = self.adView;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refeshData];
    }];

    // 注册表格
    [self.tableView registerClass:[ZJFCnListCell class] forCellReuseIdentifier:@"cnListCell"];
    
    /**搜索相关*/
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    //searchBar 自动调整大小，这句代码一定要写在设置导航栏的头视图之前
    [_searchController.searchBar sizeToFit];
    self.navigationItem.titleView = _searchController.searchBar;
    //是否覆盖导航条，默认是YES覆盖，NO不覆盖
    _searchController.hidesNavigationBarDuringPresentation = NO;
    //展示期间，蒙版是否隐藏，默认是YES,不隐藏，NO隐藏
    _searchController.dimsBackgroundDuringPresentation = YES;
    //设置提示文字
    _searchController.searchBar.placeholder = @"请输入目的地";
    _searchController.searchBar.tintColor = [UIColor blackColor];
    //设置searchBar 的代理
    _searchController.searchBar.delegate = self;
    
    _isRefesh = NO;
}

#pragma mark 下载数据相关
/**下拉刷新触发的方法*/
-(void)refeshData{
    _isRefesh = YES;
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
            
            if (_isRefesh) {
                
                [self.adViewArray removeAllObjects];
                [self.cnListArray removeAllObjects];
            }
            
            self.dataModel = dataModel;
            for (ItemsList *modelList in self.dataModel.data.flash.itemsList) {
                [self.adViewArray addObject:modelList.thumb];
            }
            // 设置广告栏方法
            [self.adView reloadAdViewData];
            [self.tableView reloadData];
            
            //停止刷新
            [self.tableView.header endRefreshing];
            //            NSLog(@"获取数据成功");

        } else {
            NSLog(@"获取数据失败");
        }
        
    }];
    
   
}

#pragma mark  UISearchBarDelegate
//当点击search时触发这个方法
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //等待提示
    [self.view addSubview:self.hud];
    [self.hud show:YES];

    //isActive 是否活跃状态
    BOOL is = [_searchController isActive];
    if (is ) {
        //如果是活跃状态进入，设置活跃状态为NO
        _searchController.active = NO;
        [self.hud hide:YES];
        
    }
    
}

#pragma mark - 表格代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 只有3组模型
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2){
        for (ExtendsList *model in self.dataModel.data.cnList.extends) {
            
            if (model.itemsList.count) {
                
                [self.cnListArray addObject:model];
            }
        }
        return self.cnListArray.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *cellId = @"cateryCell";
        
        ZJFCateryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (cell == nil) {
            
            cell = [[ZJFCateryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        [cell setCellWithModel:self.dataModel.data.navs target:self action:@selector(goToNavsListWithModel:)];
        
        return cell;
    }

    else if (indexPath.section == 1) {
        
        static NSString *specialCell = @"specialCell";
        ZJFSpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:specialCell];
        if (cell == nil) {
            cell = [[ZJFSpecialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:specialCell];
        }
        [cell setSpacialCellWithModel:self.dataModel.data.special target:self action:@selector(goToDetailVcWithUrlId:)];
        return cell;
    }
    else {
        
        ZJFCnListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cnListCell" forIndexPath:indexPath];
            
        ExtendsList *listModel = self.cnListArray[indexPath.row];
        
        CnListItemsList *model = listModel.itemsList[0];

        [cell setModelWithItemsModel:model];
    
        return cell;
    }
    
    return nil;
}

// 组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 0;
    
    return kScreenHeight * kHeadScale;
    
}

// 设置组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        
        return nil;
    
    TableHeaderView *tabelHeaderView = [[TableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * kHeadScale)];
    
    [tabelHeaderView setTitleLabelWithArray:@[@"出境游",@"国内游"] Section:section - 1];

    return tabelHeaderView;

}

// 控制每个section中的row的高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 0 section 只有一个row
    if (indexPath.section == 0 || indexPath.section == 2)
        return kScreenHeight * kCateryScale;
    
    // 其它的返回
    return kScreenHeight * kScale;
}


// 控制是否高亮
-(BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}

// 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
        DetailViewController *detailVc = [[DetailViewController alloc] init];
        
        ExtendsList *listModel = self.cnListArray[indexPath.row];
        
        CnListItemsList *model = listModel.itemsList[1];
        
        detailVc.urlId = model.url;
        
        detailVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVc animated:NO];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 广告协议方法
- (NSInteger)numberAdDatasForAdView:(ZJFAdView *)adView
{
    return self.adViewArray.count;
}

- (NSString *)adView:(ZJFAdView *)adView imageUrlAtIndex:(NSInteger)index
{
    
    NSString *imageUrl = self.adViewArray[index];
    
    return imageUrl;
}

- (void)didSelectImageAtIndex:(NSInteger)index
{
    PhotosViewController *photosVc = [[PhotosViewController alloc] init];
    
    photosVc.index = index;
    photosVc.photosArray = self.adViewArray;
    photosVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:photosVc animated:YES];
}

- (void)addPageControl:(UIPageControl *)pageControl
{
    [self.tableView addSubview:pageControl];
}


#pragma mark - 按钮点击事件
// 分类按钮点击事件
- (void)goToNavsListWithModel:(ItemsList *)model
{
    CateryViewController *cateryVc = [[CateryViewController alloc] init];
    cateryVc.url = model.url;
    cateryVc.navigationItem.title = model.title;
    cateryVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cateryVc animated:NO];
}
// 详情点击事件
- (void)goToDetailVcWithUrlId:(NSString *)urlId
{
    DetailViewController *detailVc = [[DetailViewController alloc] init];
    detailVc.urlId = urlId;
    detailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:NO];
    
}

- (void)backAction
{
    
}


#pragma mark - 懒加载
-(NSMutableArray *)cnListArray
{
    if (_cnListArray == nil) {
        
        _cnListArray = [[NSMutableArray alloc] init];
    }
    
    return _cnListArray;
}

-(NSMutableArray *)searchArray
{
    if (_searchArray == nil) {
        
        _searchArray = [[NSMutableArray alloc] init];
    }
    return _searchArray;
}

-(NSMutableArray *)adViewArray
{
    if (_adViewArray == nil) {
        _adViewArray = [[NSMutableArray alloc] init];
    }
    
    return _adViewArray;
}

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






