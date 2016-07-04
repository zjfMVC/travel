//
//  AdView.h
//  Travel
//
//  Created by qf1 on 16/1/24.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import <UIKit/UIKit.h>

// 初始化时传过一个存有图片地址的数组，使用initWithArray这个方法初始化AdView
typedef void(^GoBackBlock)();

@interface AdView : UIView

@property (nonatomic, strong) NSArray *imageArray;

-(id)initWithArray:(NSArray *)array andFrame:(CGRect)frame andBlock:(GoBackBlock)back;

@end
