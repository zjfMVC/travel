//
//  DetailViewController.m
//  Travel
//
//  Created by qf1 on 16/1/28.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#define kCateryScale 0.27
#define kScale 0.1
#import "ZJFAdView.h"
#import "DetailModel.h"
#import "DetailModel+Net.h"
#import "ZJFDetailCell.h"
#import "PhotosViewController.h"
#import "DetailViewController.h"

@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate,ZJFAdViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZJFAdView *adView;
@property (nonatomic, strong) NSArray *adViewArray;

@property (nonatomic, strong) DetailModel *detailModel;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL enabled; // 按钮是否能点
@end

@implementation DetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removePanGesture" object:nil];
    
    ZJFDBManage *manager = [ZJFDBManage shareDBManager];
    BOOL b = [manager selectWithModel:[[DetailModel alloc] init] whereWithDict:@{@"pid":_urlId}];
    // 改变button选择状态

    _isSelected = b;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getData];
    [self createUI];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - 获取数据
- (void)getData
{
    [DetailModel requestWithUrlId:_urlId compltionBlock:^(DetailModel *detailModel, NSError *error) {
        
        if (error == nil) {
//            NSLog(@"详情界面获取数据成功");
            self.adViewArray = detailModel.product_pic_list;
            
            self.detailModel = detailModel;
            
            // 数据来了按钮才能点击
            _enabled = YES;
            [self.adView reloadAdViewData];
            [self.tableView reloadData];
            
        } else {
            NSLog(@"详情界面获取数据失败");
        }
        
    }];
}

#pragma mark - 创建UI
- (void)createUI
{
    self.view.backgroundColor = [UIColor getThemeColor];
    self.title = @"产品详情";
    self.tableView.backgroundColor = [UIColor grayColor];
    
    self.adView = [[ZJFAdView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * kCateryScale)];
    self.adView.adDataSourec = self;
    [self.view addSubview:self.adView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[ZJFDetailCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.tableHeaderView = self.adView;
    
    _enabled = NO;
    
}


#pragma mark - 表格代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
    return 2;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        ZJFDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        UIButton *button = (UIButton *)[cell.contentView viewWithTag:100];
        button.enabled = _enabled;

        [cell setDetailCellWithModel:self.detailModel target:self action:@selector(collectionWithDetailModel:button:) isSelected:_isSelected];
        return cell;
        
    } else {
        
        static NSString *cellId = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        if (indexPath.section == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"集合地:%@  目的地:%@",self.detailModel.city,_detailModel.scenic];
        } else {
            if (indexPath.row == 0) {
                cell.textLabel.text = [NSString stringWithFormat:@"出发时间:%@",_detailModel.starttime];
            } else {
                cell.textLabel.text = [NSString stringWithFormat:@"客服电话:400-670-6300"];
            }
        }
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
/**
 *  组尾高度
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

// 控制每个section中的row的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 0 section 只有一个row
    if (indexPath.section == 0) {
        return kScreenHeight * kCateryScale;
    }
    
    // 其它的返回
    return kScreenHeight * kScale;
}


#pragma mark - 收藏点击
- (void)collectionWithDetailModel:(DetailModel *)detailModel button:(UIButton *)button
{    
    button.selected = !(button.selected);
    
    ZJFDBManage *manager = [ZJFDBManage shareDBManager];
    if (button.selected) {
        // 插入数据
        [manager insertDbWithModel:detailModel];
        _isSelected = YES;
        
    } else {
        // 删除数据
        [manager deleteAllDataWithModel:detailModel whereWithUlrStr:detailModel.pid];
        _isSelected = NO;
    }
    

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
