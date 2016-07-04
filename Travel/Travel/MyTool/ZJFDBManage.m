//
//  ZJFDBManage.m
//  LimitFree
//
//  Created by qf1 on 16/1/10.
//  Copyright (c) 2016年 Jarvan. All rights reserved.
//

#import "ZJFDBManage.h"

@interface ZJFDBManage ()
{
    // 线程（队列）
    FMDatabaseQueue *_queue;
}

@end

static ZJFDBManage *manager = nil;
@implementation ZJFDBManage
// 获取单例
+ (instancetype)shareDBManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // init会调用下面重写的初始化方法
        manager = [[ZJFDBManage alloc] init];
    });
    
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}

#pragma mark - 重写父类初始化方法，打开数据库
- (instancetype)init
{
    if (self = [super init]) {
        // 沙盒路径
//        NSString *path = [NSString stringWithFormat:@"%@/Documents/zjfDb.db",NSHomeDirectory()];
        NSString* docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"zjfTravel.db"];
        // 打开数据库
        _queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        NSLog(@"DBPath %@",dbPath);
    }
    
    return self;
}

#pragma mark - 获取模型成员变量的名字
- (NSArray *)getAllPropertyNameWithTableName:(NSString *)tableName
{
    NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
    // 成员变量的个数
    unsigned int count;
    Ivar *vars = class_copyIvarList(NSClassFromString(tableName), &count);
    
    for (int i=0; i<count; i++) {
        Ivar var = vars[i];
        // 获取成员变量名字
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(var)];
        [propertyArray addObject:propertyName];
    }
    
    return propertyArray;
}

#pragma mark - 创建表格
- (void)createTableWithTableName:(NSString *)tableName
{
    // create table 表名(字段名，字段名···)
    /**
     类名作为表格名来创建表格，并通过类名来获取属性名作为对应的字段名
     */
    // 获取一个类的成员变量名以及成员类型(模型类)
    NSArray *propertyName = [self getAllPropertyNameWithTableName:tableName];
    
    // 拼接SQL语句
    NSMutableString *sqlStr = [[NSMutableString alloc] init];
    
    for (int i=0; i<propertyName.count; i++) {
        
        if (i == 0) {
            [sqlStr appendFormat:@"%@",propertyName[i]];
        } else {
            [sqlStr appendFormat:@",%@",propertyName[i]];
        }
    }
    
    NSString *sql = [NSString stringWithFormat:@"create table %@(%@)",tableName,sqlStr];
    [_queue inDatabase:^(FMDatabase *db) {
        
        BOOL b = [db executeUpdate:sql];
        
        if (b) {
            NSLog(@"%@表格创建成功",tableName);
        } else {
            NSLog(@"%@表格创建失败",tableName);
        }
    }];

}

#pragma mark - 插入数据
- (BOOL)insertDbWithModel:(id)model
{
    // 通过model实例来获取类名作为表名创建表格
    NSString *tableName = [NSString stringWithUTF8String:object_getClassName(model)];
    
    // 通过类名获取属性名
    NSArray *propertyName = [self getAllPropertyNameWithTableName:tableName];
    // 创建表格
    [self createTableWithTableName:tableName];
    // 拼接sql语句
    // insert into 表名 values(?,?)
    NSMutableString *sqlStr = [[NSMutableString alloc] init];
    NSMutableArray *muArray = [[NSMutableArray alloc] init];
    for (int i=0; i<propertyName.count; i++) {
        if (i == 0) {
            [sqlStr appendFormat:@"?"];
        } else {
            [sqlStr appendFormat:@",?"];
        }
        // 将values(?,?)对应的值存入数组中
        if ([model valueForKey:propertyName[i]] == nil) {
            [muArray addObject:@""];
        } else {
            [muArray addObject:[model valueForKey:propertyName[i]]];
        }
    }
    
    NSString *sql = [NSString stringWithFormat:@"insert into %@ values(%@)",tableName,sqlStr];
    
    __block BOOL isStatus = NO;

    [_queue inDatabase:^(FMDatabase *db) {
        BOOL b = [db executeUpdate:sql withArgumentsInArray:muArray];
        
        if (b) {
            NSLog(@"%@插入数据成功",tableName);
            isStatus = YES;
        } else {
            NSLog(@"%@插入数据失败",tableName);
            isStatus = NO;
        }
    }];
    
    return isStatus;
}

#pragma mark - 删除整张表格的数据
- (BOOL)deleteTableWithModel:(id)model
{
    __block BOOL isStatus = NO;
    
    NSString *tableName = [NSString stringWithUTF8String:object_getClassName(model)];
    NSString *sql = [NSString stringWithFormat:@"delete from %@",tableName];
    
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL b = [db executeUpdate:sql];
        if (b) {
            NSLog(@"%@表格删除成功",tableName);
            isStatus = YES;
        } else {
            NSLog(@"%@表格删除失败",tableName);
            isStatus = NO;
        }
    }];
    
    return isStatus;
}

#pragma mark - 删除表格中某个模型的所有数据
- (BOOL)deleteModelWithModel:(id)model
{
    NSString *tableName = [NSString stringWithUTF8String:object_getClassName(model)];
    NSArray *propertyArray = [self getAllPropertyNameWithTableName:tableName];
    
    NSMutableString *keyString = [NSMutableString string];
    NSMutableArray *valueArray = [NSMutableArray array];
    
    for (int i=0; i<propertyArray.count; i++) {
        if (i == 0) {
            [keyString appendFormat:@"%@=?",propertyArray[i]];
        }else{
            // 注意这里的空格
            [keyString appendFormat:@" and %@=?",propertyArray[i]];
        }
        
        // 删除数据:delete from ZYZFirsrModel where _name=? and _price=?
        if ([model valueForKey:propertyArray[i]] == nil) {
            [valueArray addObject:@""];
        }else{
            [valueArray addObject:[model valueForKey:propertyArray[i]]];
        }
        
    }
    
    // 删除表格中含有keyString字段的数据
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@",tableName,keyString];
    
    __block BOOL isStatus = NO;
    [_queue inDatabase:^(FMDatabase *db) {
        // 要删除的字段对应的值放到数组valueArray中
        BOOL b = [db executeUpdate:sql withArgumentsInArray:valueArray];
        
        if (b) {
            NSLog(@"删除模型成功");
            isStatus = NO;
        } else {
            NSLog(@"删除模型失败");
            isStatus = YES;
        }
    }];
    
    return isStatus;
    
}

#pragma mark - 按条件删除(删除某个字段对应的值相同的所有数据)
- (BOOL)deleteAllDataWithModel:(id)model whereWithUlrStr:(NSString *)urlStr
{
    __block BOOL isStatus = NO;
    
    NSString *tableName = [NSString stringWithUTF8String:object_getClassName(model)];
    // 注意下划线_urlStr，因为那是成员变量名带下划线，还有单引号'%@'
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where _pid='%@'",tableName,urlStr];
//    NSLog(@"%@",sql);
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL isSucceed = [db executeUpdate:sql];
        if (isSucceed) {
            NSLog(@"%@页面删除数据成功",urlStr);
            isStatus = YES;
        }else{
            NSLog(@"%@页面删除数据失败",urlStr);
            isStatus = NO;
        }
    }];
    
    return isStatus;
    
}

#pragma mark - 查询
- (NSMutableArray *)selectWithModel:(id)model whereWithUlrStr:(NSString *)urlStr
{
    // 用来存放查询结果
    NSMutableArray *selectArray = [[NSMutableArray alloc] init];
    
    NSString *tableName = [NSString stringWithUTF8String:object_getClassName(model)];
    
    NSString *sql;
    // 当urlStr不为空时，查询某个字段对应的值相同的所有数据
    if (urlStr) {
        sql = [NSString stringWithFormat:@"select * from %@ where _urlStr='%@'",tableName,urlStr];
    } else {
        // 当urlStr为空时，无查询条件，查询整张表格的数据
        sql = [NSString stringWithFormat:@"select * from %@",tableName];
    }
    
    NSArray *propertyArray = [self getAllPropertyNameWithTableName:tableName];
    
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql];
        while ([set next]) {
            // 通过类名来获取该类
            Class class = NSClassFromString(tableName);
            // 实例化获取该类的对象（模型）
            id model = [[class alloc] init];
            
            for (int i=0; i<propertyArray.count; i++) {
                // 给model模型的属性赋值
                [model setValue:[set stringForColumn:propertyArray[i]] forKey:propertyArray[i]];
            }
            
            [selectArray addObject:model];
        }
    }];
    
    return selectArray;
}

#pragma mark - 按条件查询数据
- (BOOL)selectWithModel:(id)model whereWithDict:(NSDictionary *)dict
{
    __block BOOL isStatus = NO;
    
    NSString *tableName = [NSString stringWithUTF8String:object_getClassName(model)];
    
    for (NSString *key in dict) {
        
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where _%@='%@'",tableName,key,dict[key]];
        
        [_queue inDatabase:^(FMDatabase *db) {
            FMResultSet *set = [db executeQuery:sql];
            while ([set next]) {
                isStatus = YES;
            }
        }];
    }
    
    return isStatus;
}

@end















