//
//  ZJFVideosModel+Net.m
//  Travel
//
//  Created by qf1 on 16/2/4.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "ZJFVideosModel+Net.h"

@implementation ZJFVideosModel (Net)

+(void)requestVideosWithPage:(NSInteger)page compltionBlock:(CompletionBlock )block
{
    NSString *pageStr = [NSString stringWithFormat:@"%ld",page];
    NSString *url = [NSString stringWithFormat:Videos_Url,pageStr];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //json数据的解析
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        // 转模型
        ZJFVideosModel *videosModel = [[ZJFVideosModel alloc] initWithDictionary:dict error:nil];
        NSMutableArray *muArray = [[NSMutableArray alloc] init];
        for ( ContentModel *contentModel in videosModel.content) {
            
            [muArray addObject:contentModel];
        }
        //使用block，将数组传回去
        block(muArray,nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        block(nil,error);
    }];
 
}


+(void)requestVideosWithTags:(NSString *)tags compltionBlock:(CompletionBlock )block
{
    
    NSString *codeUrl = [NSString stringWithFormat:VideosCatery_Url,tags];
    // 解码
    NSString *url = [codeUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //json数据的解析
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        // 转模型
        ZJFVideosModel *videosModel = [[ZJFVideosModel alloc] initWithDictionary:dict error:nil];
        NSMutableArray *muArray = [[NSMutableArray alloc] init];
        for ( ContentModel *contentModel in videosModel.content) {
            
            [muArray addObject:contentModel];
        }
        //使用block，将数组传回去
        block(muArray,nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        block(nil,error);
    }];

}


@end



















