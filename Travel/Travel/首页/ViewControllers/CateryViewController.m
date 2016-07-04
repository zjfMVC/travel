//
//  CateryViewController.m
//  Travel
//
//  Created by qf1 on 16/2/3.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#define kAdViewScale 0.25
#define kCellScale 0.3
#import "ZJFAdView.h"
#import "DetailViewController.h"
#import "CollectionHeaderView.h"

#import "ZJFCateryListCell.h"
#import "CateryModel.h"
#import "CateryModel+Net.h"
#import "PhotosViewController.h"
#import "CateryViewController.h"

@interface CateryViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ZJFAdViewDataSource>
@property (nonatomic, strong) CollectionHeaderView *headView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CateryModel *cateryModel;
@end

@implementation CateryViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removePanGesture" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
    [self createUI];
}

- (void)back {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 获取数据
- (void)getData
{
   [CateryModel requestWithUrl:_url compltionBlock:^(CateryModel *cateryModel, NSError *error) {
       
       if (error == nil) {
//           NSLog(@"获取分类数据成功");
           
           self.cateryModel = cateryModel;
           [self.collectionView reloadData];
           [self.headView.adView reloadAdViewData];
       } else {
           NSLog(@"获取分类数据失败");
       }
       
   }];
    
}


#pragma mark - 创建UI
- (void)createUI
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[ZJFCateryListCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [_collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

}


#pragma mark UICollectionView代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cateryModel.data.productList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZJFCateryListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.productListModel = self.cateryModel.data.productList[indexPath.item];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //设置cell的大小
    return CGSizeMake(kScreenWidth/2, kScreenHeight * kCellScale);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    //设置和collectionView滑动方向不一致的方向的最小间隔
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    //设置和collectionView滑动方向一致的方向的间隔
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //设置分组四周的间距
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductListModel *productListModel = self.cateryModel.data.productList[indexPath.item];
    DetailViewController *detailVc = [[DetailViewController alloc] init];
    detailVc.urlId = productListModel.pid;
    
    detailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //和cell一样，段头段尾都有复用机制
    _headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    _headView.adView.adDataSourec = self;
    
    return _headView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    //设置段头的大小,如果滑动方向是纵向，宽度设置无效
    return CGSizeMake(0, kScreenHeight * kAdViewScale);
}



#pragma mark - 广告协议方法
- (NSInteger)numberAdDatasForAdView:(ZJFAdView *)adView
{
    return self.cateryModel.data.flashList.count;
}

- (NSString *)adView:(ZJFAdView *)adView imageUrlAtIndex:(NSInteger)index
{
    FlashListModel *flashListModel = self.cateryModel.data.flashList[index];
    
    NSString *imageUrl = flashListModel.thumb;
    
    return imageUrl;
}

- (void)didSelectImageAtIndex:(NSInteger)index
{
    PhotosViewController *photosVc = [[PhotosViewController alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (FlashListModel *model in self.cateryModel.data.flashList) {
        
        [tempArray addObject:model.thumb];
    }
    photosVc.photosArray = tempArray;
    photosVc.index = index;
    photosVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:photosVc animated:NO];
}

- (void)addPageControl:(UIPageControl *)pageControl
{
    [self.collectionView addSubview:pageControl];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end














