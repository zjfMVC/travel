//
//  ZJFDataModel.h
//  Travel
//
//  Created by qf1 on 16/1/25.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "JSONModel.h"
#import "NavsModel.h"
#import "FlashModel.h"
#import "RouteModel.h"
#import "SpecialModel.h"
#import "CnListModel.h"

#pragma mark - 第二层模型
@interface DataModel : JSONModel
// 分类模型
@property (nonatomic, strong) NavsModel *navs;
// 广告栏模型
@property (nonatomic, strong) FlashModel *flash;
// 周边模型
@property (nonatomic, strong) RouteModel *route;
// 境外模型
@property (nonatomic, strong) SpecialModel *special;
// 国内模型
@property (nonatomic, strong) CnListModel *cnList;

@property (nonatomic, strong) NSDictionary *suggest;

@end

#pragma mark - 最外层模型
@interface ZJFDataModel : JSONModel

@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *cache;

@property (nonatomic, strong) DataModel *data;

@end






