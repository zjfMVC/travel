//
//  ZJFRouteCell.h
//  Travel
//
//  Created by qf1 on 16/1/26.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "RouteModel.h"
#import "SpecialModel.h"
#import <UIKit/UIKit.h>

@interface ZJFRouteCell : UITableViewCell

@property (nonatomic,weak)id target;
@property (nonatomic,assign)SEL action;

- (void)setCellWithModel:(RouteModel *)routeModel target:(id)target action:(SEL)action;

@end
