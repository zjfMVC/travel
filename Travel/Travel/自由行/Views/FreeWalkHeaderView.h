//
//  FreeWalkHeaderView.h
//  Travel
//
//  Created by qf1 on 16/2/17.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeWalkHeaderView : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
// 设置文字
- (void)setLabelTextWithArray:(NSArray *)array;
@end
