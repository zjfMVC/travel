//
//  FreeWalkModel+Net.m
//  Travel
//
//  Created by qf1 on 16/2/16.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "FreeWalkModel+Net.h"

@implementation FreeWalkModel (Net)

+(void)requestFreeWalkWithPage:(NSInteger)page compltionBlock:(CompletionBlock )block
{
    NSString *pageStr = [NSString stringWithFormat:@"%ld",page];
    NSString *url = [NSString stringWithFormat:FreeWalk_Url,pageStr];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //json数据的解析
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArray = dict[@"data"];
        // 转模型
        NSMutableArray *muArray = [[NSMutableArray alloc] init];
        for ( NSDictionary *freeWalkDict in dataArray) {
            FreeWalkModel *freeWalkModel = [[FreeWalkModel alloc] init];
            [freeWalkModel setValuesForKeysWithDictionary:freeWalkDict];
            [muArray addObject:freeWalkModel];
        }
        //使用block，将数组传回去
        block(muArray,nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        block(nil,error);
    }];
    
}

@end



