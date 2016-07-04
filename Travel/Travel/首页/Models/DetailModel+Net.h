//
//  DetailModel+Net.h
//  Travel
//
//  Created by qf1 on 16/1/28.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "DetailModel.h"

typedef void(^CompletionBlock)(DetailModel *detailModel,NSError *error);

@interface DetailModel (Net)

+(void)requestWithUrlId:(NSString *)urlId compltionBlock:(CompletionBlock )block;

@end
