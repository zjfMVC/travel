//
//  ZJFVideosModel+Net.h
//  Travel
//
//  Created by qf1 on 16/2/4.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "ZJFVideosModel.h"

typedef void(^CompletionBlock)(NSMutableArray *array,NSError *error);
@interface ZJFVideosModel (Net)
// 推荐接口
+(void)requestVideosWithPage:(NSInteger)page compltionBlock:(CompletionBlock )block;

// 分类接口
+(void)requestVideosWithTags:(NSString *)tags compltionBlock:(CompletionBlock )block;

@end
