//
//  FreeWalkModel+Net.h
//  Travel
//
//  Created by qf1 on 16/2/16.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "FreeWalkModel.h"
typedef void(^CompletionBlock)(NSMutableArray *array,NSError *error);

@interface FreeWalkModel (Net)

+(void)requestFreeWalkWithPage:(NSInteger)page compltionBlock:(CompletionBlock )block;

@end
