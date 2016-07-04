//
//  CateryModel+Net.h
//  Travel
//
//  Created by qf1 on 16/2/3.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "CateryModel.h"

@interface CateryModel (Net)

typedef void(^CompletionBlock)(CateryModel *cateryModel,NSError *error);

+(void)requestWithUrl:(NSString *)url compltionBlock:(CompletionBlock )block;

@end
