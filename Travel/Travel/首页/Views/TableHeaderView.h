//
//  TableHeaderView.h
//  Travel
//
//  Created by qf1 on 16/1/29.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableHeaderView : UIView

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSArray *titleArray;

- (void)setTitleLabelWithArray:(NSArray *)array Section:(NSInteger)section;
@end
