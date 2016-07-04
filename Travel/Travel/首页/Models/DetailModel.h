//
//  DetailModel.h
//  Travel
//
//  Created by qf1 on 16/1/28.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

//"data": {
//    "pid": "11398",
//    "sitecode": "8",
//    "class_id": "3",
//    "product_name": "【从版纳到老挝】2016年 云南 西双版纳-老挝孟塞-琅勃拉邦-磨丁，温暖佛国8日慢生活，深度跨境游！（无需护照）",
//    "days": "8",
//    "sub_name": "游侠客独创跨境路线！游侠客专业领队！充裕时间充分自由体验老挝淳朴慢生活！",
//    "province_id": "530000",
//    "city_id": "532800",
//    "is_free": "0",
//    "province": "云南省",
//    "city": "西双版纳傣族自治州",
//    "scenic": "西双版纳",
//    "price_status": "1",
//    "price": "3980",
//    "people": "214",
//    "batchs": [],
//    "starttime": "2016-01-30 ...",
//    "appoffer": "优惠: 移动App下单，首单立减 20 元",
//    "class_theme_id": "7",
//    "class_region_id": "2",
//    "class_theme": "深度游",
//    "class_region": "国内",
//    "sitename": "国内",
//    "product_pic": "",
//    "product_pic_list": [] }

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *product_name;
@property (nonatomic, strong) NSString *days;
@property (nonatomic, strong) NSString *sub_name;
@property (nonatomic, strong) NSString *is_free;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *scenic;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *people;
@property (nonatomic, strong) NSString *starttime;
@property (nonatomic, strong) NSString *class_theme;
@property (nonatomic, strong) NSString *class_region;
@property (nonatomic, strong) NSString *appoffer;
@property (nonatomic, strong) NSString *product_pic;
@property (nonatomic, strong) NSArray *product_pic_list;


@end
