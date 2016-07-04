//
//  DetailModel+Net.m
//  Travel
//
//  Created by qf1 on 16/1/28.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "DetailModel+Net.h"

@implementation DetailModel (Net)


+(void)requestWithUrlId:(NSString *)urlId compltionBlock:(CompletionBlock )block
{
    NSString *url = [NSString stringWithFormat:Detail_Url,urlId];
    //1获得manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2设置responseObject 的类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //3向服务器发起请求
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //json数据的解析
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dataDict = dict[@"data"];
        // 转模型
        DetailModel *detailModel = [[DetailModel alloc] init];
        [detailModel setValuesForKeysWithDictionary:dataDict];
        
        //使用block，将数组传回去
        block(detailModel,nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        block(nil,error);
    }];
    
}

@end
