//
//  ZJFCateryCell.h
//  Travel
//
//  Created by qf1 on 16/1/26.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "ZJFDataModel.h"
#import "NavsModel.h"
#import <UIKit/UIKit.h>

@interface ZJFCateryCell : UITableViewCell

@property (nonatomic,weak)id target;
@property (nonatomic,assign)SEL action;

- (void)setCellWithModel:(NavsModel *)navsModel target:(id)target action:(SEL)action;

@end
