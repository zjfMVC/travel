//
//  CnListModel.h
//  Travel
//
//  Created by qf1 on 16/1/25.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
//"cnList": {
//    "alias": "cnList",
//    "name": "国内游",
//    "itemsList": [ ],
//    "extends": [
//                {
//                    "alias": "cntab2",
//                    "name": "东北",
//                    "itemsList": [
//                                  {
//                                      "title": "东北冰雪休闲",
//                                      "url": "10832",
//                                      "thumb": "http://qimg5.youxiake.com/app/201510/26/pager/fc564e06c2258b75e9b597e3b0b5690c.png!p6",
//                                      "gmt_expired": "2016-02-22",
//                                      "handler": "product_detail"
//                                  },
//                                  {},
//                                  {},
//                                  {},
//                                  {},
//                                  {}
//                                  ],
//                    "extends": [ ],
//                    "idx": "1"
//                },
//                {},
//                {},
//                {}
//                ],
//    "idx": "6",
//    "moreLink": "http://app2.youxiake.com/n.php/activity,group,detail?alias=PAGE_TYPE_GUONEI&type=5",
//    "handler": "product_list"
//}

#import "JSONModel.h"

@protocol CnListItemsList <NSObject>
@end

@interface CnListItemsList : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *gmt_expired;
@property (nonatomic, strong) NSString *handler;
@end

@protocol ExtendsList <NSObject>
@end

@interface ExtendsList : JSONModel

@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *extends;
@property (nonatomic, strong) NSString *idx;

@property (nonatomic, strong) NSArray<CnListItemsList,ConvertOnDemand> *itemsList;

@end

@interface CnListModel : JSONModel

@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *itemsList;
@property (nonatomic, strong) NSString *idx;
@property (nonatomic, strong) NSString *moreLink;
@property (nonatomic, strong) NSString *handler;

@property (nonatomic, strong) NSArray<ExtendsList,ConvertOnDemand> *extends;

@end

















