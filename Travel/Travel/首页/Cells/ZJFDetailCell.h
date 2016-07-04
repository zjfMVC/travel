//
//  ZJFDetailCell.h
//  Travel
//
//  Created by qf1 on 16/1/28.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "DetailModel.h"
#import <UIKit/UIKit.h>

@interface ZJFDetailCell : UITableViewCell

@property (nonatomic, weak)id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, assign) BOOL isSelected; // 标记是否被收藏

//@property (nonatomic, strong) DetailModel *model;

- (void)setDetailCellWithModel:(DetailModel *)detailModel target:(id)target action:(SEL)action isSelected:(BOOL)isSelected;

@end
