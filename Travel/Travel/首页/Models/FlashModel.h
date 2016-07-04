//
//  FlashModel.h
//  Travel
//
//  Created by qf1 on 16/1/25.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
//"flash": {
//    "alias": "flash",
//    "name": "首页幻灯",
//    "itemsList": [
//                  {
//                      "gmt_expired": "2016-02-20",
//                      "title": "东北之旅",
//                      "url": "http://www.youxiake.com/db",
//                      "thumb": "http://qimg5.youxiake.com/app/201601/20/pager/3fa231da4f35813afa8faf76dbc4758c.jpg!p6",
//                      "handler": "html5"
//                  },
//                  {},
//                  {},
//                  {},
//                  {},
//                  {}
//                  ],
//    "extends": [ ],
//    "idx": "2"
//},

#import "JSONModel.h"

@protocol FlashItemsList <NSObject>
@end


@interface FlashItemsList : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *gmt_expired;
@property (nonatomic, strong) NSString *handler;


@end


@interface FlashModel : JSONModel

@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *extends;
@property (nonatomic, strong) NSString *idx;

@property (nonatomic, strong) NSArray<FlashItemsList,ConvertOnDemand> *itemsList;
@end





















