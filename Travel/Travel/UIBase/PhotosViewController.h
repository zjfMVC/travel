//
//  PhotosViewController.h
//  Travel
//
//  Created by qf1 on 16/2/19.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosViewController : UIViewController

/** 图片的数组*/
@property (nonatomic,strong) NSArray *photosArray;
/** 第几张点击*/
@property (nonatomic,assign) NSInteger index;

@end
