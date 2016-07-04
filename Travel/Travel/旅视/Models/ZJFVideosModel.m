//
//  ZJFVideosModel.m
//  Travel
//
//  Created by qf1 on 16/2/4.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "ZJFVideosModel.h"

@implementation ContentModel

//访问description对应的属性的时去访问kDescription这个字符串对应的属性
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"myId"}];
}
@end



@implementation ZJFVideosModel

@end
