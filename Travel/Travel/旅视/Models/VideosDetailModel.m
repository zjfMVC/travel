//
//  VideosDetailModel.m
//  Travel
//
//  Created by qf1 on 16/2/6.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "VideosDetailModel.h"

@implementation VideosDetailModel

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"myId"}];
}

@end
