//
//  ZJFSpecialCell.h
//  Travel
//
//  Created by qf1 on 16/1/28.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "SpecialModel.h"
#import <UIKit/UIKit.h>

@interface ZJFSpecialCell : UITableViewCell

@property (nonatomic,weak)id target;
@property (nonatomic,assign)SEL action;

- (void)setSpacialCellWithModel:(SpecialModel *)specialModel target:(id)target action:(SEL)action;

@end
