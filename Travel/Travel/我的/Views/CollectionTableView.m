//
//  CollectionTableView.m
//  Travel
//
//  Created by qf1 on 16/2/21.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#define kCollectionCell 0.2
#import "DetailModel.h"
#import "CollectionTableView.h"

@interface CollectionTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, copy) CollectionBlock block;
@property (nonatomic, copy) CollectionBlock deleteBlock;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CollectionTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        self.dataArray = [[NSMutableArray alloc] init];
        
        self.delegate = self;
        self.dataSource = self;
        
//        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// 代码块
- (void)customWithArray:(NSArray *)dataArray complimentBlock:(CollectionBlock)block
{
    _block = block;
    [_dataArray addObjectsFromArray:dataArray];
    [self reloadData];
}

#pragma mark - 表格代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    
    DetailModel *detailModel = self.dataArray[indexPath.row];
    NSString *imageUrl = detailModel.product_pic;
    cell.textLabel.text = detailModel.product_name;
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    cell.detailTextLabel.text = detailModel.sub_name;
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight * kCollectionCell;
}

//提交编辑执行的代理方法
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailModel *detailModel = [_dataArray objectAtIndex:indexPath.row];
    
    [_dataArray removeObjectAtIndex:indexPath.row];
    
    ZJFDBManage *manage = [ZJFDBManage shareDBManager];
    
    [manage deleteAllDataWithModel:[[DetailModel alloc] init] whereWithUlrStr:detailModel.pid];
    
    [self reloadData];
    
}


//返回表格的编辑形式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
        
}


-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //    先获取到用户点击的这一行在数组中对应的数据
//    DetailModel *detailModel = [[_dataArray objectAtIndex:sourceIndexPath.section] objectAtIndex:sourceIndexPath.row];
    //            //    在将该条数据从原数组中删除
//    [[_dataArray objectAtIndex:sourceIndexPath.section] removeObjectAtIndex:sourceIndexPath.row];


}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_block) {
        // 代码块回调
        _block(indexPath);
    }
    
    [self deselectRowAtIndexPath:indexPath animated:YES];
}


@end












