//
//  CateryModel+Net.m
//  Travel
//
//  Created by qf1 on 16/2/3.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "CateryModel+Net.h"

@implementation CateryModel (Net)

+(void)requestWithUrl:(NSString *)url compltionBlock:(CompletionBlock )block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //json数据的解析
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        // 转模型
        CateryModel *cateryModel = [[CateryModel alloc] initWithDictionary:dict error:nil];
//        NSLog(@"%@",cateryModel);
        //使用block，将模型传回去
        block(cateryModel,nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        block(nil,error);
    }];
    
 
}

@end
