//
//  ZJFDataModel+Net.h
//  Travel
//
//  Created by qf1 on 16/1/26.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "ZJFDataModel.h"

@interface ZJFDataModel (Net)

typedef void(^CompletionBlock)(ZJFDataModel *dataModel,NSError *error);

+(void)requestWithPage:(NSString *)page compltionBlock:(CompletionBlock )block;

@end
