//
//  ZJFDataModel+Net.m
//  Travel
//
//  Created by qf1 on 16/1/26.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "ZJFDataModel+Net.h"

@implementation ZJFDataModel (Net)

+(void)requestWithPage:(NSString *)page compltionBlock:(CompletionBlock )block{
    
    //1获得manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2设置responseObject 的类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //3向服务器发起请求
    [manager GET:Home_Url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //json数据的解析
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        // 转模型
        ZJFDataModel *dataModel = [[ZJFDataModel alloc] initWithDictionary:dict error:nil];
        //使用block，将数组传回去
//        NSLog(@"%@",dataModel.data.flash.itemsList);
        block(dataModel,nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        block(nil,error);
    }];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:Home_Url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        // 转模型
//        ZJFDataModel *dataModel = [[ZJFDataModel alloc] initWithDictionary:dict error:nil];
//        //使用block，将数组传回去
//        //        NSLog(@"%@",dataModel.data.flash.itemsList);
//        block(dataModel,nil);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        block(nil,error);
//    }];
}

@end











