//
//  VideosHeaderView.h
//  Travel
//
//  Created by qf1 on 16/2/5.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideosHeaderView : UIView

@property (nonatomic,weak)id target;
@property (nonatomic,assign)SEL action;

- (void)addButtonEventWithTarget:(id)target action:(SEL)action;

@end
