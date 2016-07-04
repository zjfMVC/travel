//
//  ZJFDBManage.h
//  LimitFree
//
//  Created by qf1 on 16/1/10.
//  Copyright (c) 2016年 Jarvan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJFDBManage : NSObject

// 快速实例化对象
+ (instancetype)shareDBManager;

// 插入数据
- (BOOL)insertDbWithModel:(id)model;

// 删除整张表格的数据
- (BOOL)deleteTableWithModel:(id)model;

// 删除表格中某个模型的所有数据
- (BOOL)deleteModelWithModel:(id)model;

// 按条件删除(删除某个字段对应的值相同的所有数据)
- (BOOL)deleteAllDataWithModel:(id)model whereWithUlrStr:(NSString *)urlStr;

// 查询
- (NSMutableArray *)selectWithModel:(id)model whereWithUlrStr:(NSString *)urlStr;

// 按条件查询
- (BOOL)selectWithModel:(id)model whereWithDict:(NSDictionary *)dict;
@end









