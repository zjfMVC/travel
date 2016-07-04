//
//  CollectionViewController.m
//  Travel
//
//  Created by qf1 on 16/2/20.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "DetailModel.h"
#import "CollectionTableView.h"
#import "DetailViewController.h"
#import "CollectionViewController.h"

@interface CollectionViewController ()

@property (nonatomic, strong) CollectionTableView *collectionTableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation CollectionViewController

- (void)viewWillAppear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiderMakeView" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removePanGesture" object:nil];
    [super viewWillAppear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    
}


#pragma mark - 创建UI
- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    rightBarItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    
    UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    leftBarItem.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftBarItem;

    
    _collectionTableView = [[CollectionTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:_collectionTableView];

    
    // 查询获取数据
    _dataArray = [self selectData];
    
    [_collectionTableView customWithArray:_dataArray complimentBlock:^(NSIndexPath *indexPath) {
        
        DetailModel *detailModel = _dataArray[indexPath.row];
        
        DetailViewController *detailVc = [[DetailViewController alloc] init];
        detailVc.urlId = detailModel.pid;
        
        [self.navigationController pushViewController:detailVc animated:YES];
        
        [self.collectionTableView reloadData];
        
    }];


}

-(void)rightItemAction{
    
    //    设置表格为可编辑状态
    _collectionTableView.editing = !(_collectionTableView.editing);
    if (_collectionTableView.editing) {
        self.navigationItem.rightBarButtonItem.title = @"编辑中";
        
    } else {
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        
    }
    
    
}

-(void)leftItemAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 查询数据
- (NSArray *)selectData
{
    ZJFDBManage *manage = [ZJFDBManage shareDBManager];
    
    NSArray *array = [manage selectWithModel:[[DetailModel alloc] init] whereWithUlrStr:nil];
    
    return array;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
















