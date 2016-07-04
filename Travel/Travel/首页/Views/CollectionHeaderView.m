//
//  CollectionHeaderView.m
//  Travel
//
//  Created by qf1 on 16/2/3.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "CollectionHeaderView.h"

@implementation CollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _adView = [[ZJFAdView alloc] initWithFrame:frame];
        [self addSubview:_adView];
    }
    return self;
}

@end
