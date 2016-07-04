//
//  CateryModel.h
//  Travel
//
//  Created by qf1 on 16/2/3.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
//"productList": [
//                {
//                    "pid": "11541",
//                    "starttime": "1454428800",
//                    "price_status": "1",
//                    "adultprice": "1460.00",
//                    "class_id": "3",
//                    "product_name": "[神州北极]2015-16年 踏雪中国北极，漠河-北红村-驯鹿园-北极村-圣诞村4日东北游",
//                    "sub_name": "站在最北，眼前就是整个祖国大地",
//                    "sitecode": "8",
//                    "city_id": "232700",
//                    "province_id": "230000",
//                    "days": "/4天",
//                    "price": "1460",
//                    "thumb": "http://gallery.youxiake.com/Public/Data/upload/productimg/201509/19/55fd100f7f40b.jpg",
//                    "place_label": "大兴安岭地区集合",
//                    "product_type": "深度游",
//                    "class_theme_id": "7",
//                    "product_cat": "跟团游"
//                },
#import "JSONModel.h"
#pragma mark - 第三层模型
// 产品详情模型
@protocol ProductListModel <NSObject>
@end

@interface ProductListModel : JSONModel

@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *starttime;
@property (nonatomic, copy) NSString *adultprice;
@property (nonatomic, copy) NSString *product_name;
@property (nonatomic, copy) NSString *sub_name;
@property (nonatomic, copy) NSString *days;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *place_label;
@property (nonatomic, copy) NSString *product_type;
@property (nonatomic, copy) NSString *product_cat;
@end


// 广告栏模型
@protocol FlashListModel <NSObject>
@end

@interface FlashListModel : JSONModel

@property (nonatomic, copy) NSString *gmt_expired;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *handler;
@end


#pragma mark - 第二层模型
@interface CateryDataModel : JSONModel
// 广告栏模型
@property (nonatomic, strong) NSArray<FlashListModel,ConvertOnDemand> *flashList;
// 产品详情模型
@property (nonatomic, strong) NSArray<ProductListModel,ConvertOnDemand> *productList;

@property (nonatomic, copy) NSString *moreLink;
@property (nonatomic, copy) NSString *searchKey;
@property (nonatomic, copy) NSString *sitecode;
@property (nonatomic, strong) NSArray<Optional> *tagsList;

@end


#pragma mark - 最外层模型
@interface CateryModel : JSONModel

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *cache;

@property (nonatomic, strong) CateryDataModel *data;

@end
