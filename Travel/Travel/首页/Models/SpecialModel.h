//
//  SpecialModel.h
//  Travel
//
//  Created by qf1 on 16/1/25.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

//"special": {
//    "alias": "special",
//    "name": "出境游",
//    "itemsList": [
//                  {
//                      "title": "斯里兰卡",
//                      "url": "斯里兰卡",
//                      "thumb": "http://qimg5.youxiake.com/app/201601/13/pager/c1f4487a49c28fa8876c77f734a67e96.jpg!p6",
//                      "gmt_expired": "2016-12-28",
//                      "handler": "search_list"
//                  },
//                  {},
//                  {}
//                  ],
//    "extends": [ ],
//    "idx": "5",
//    "moreLink": "http://app2.youxiake.com/n.php/activity,group,detail?alias=PAGE_TYPE_CHUJING&type=6",
//    "handler": "product_list"
//},

#import "JSONModel.h"

@protocol SpecialItemsList <NSObject>
@end


@interface SpecialItemsList : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *gmt_expired;
@property (nonatomic, strong) NSString *handler;


@end


@interface SpecialModel : JSONModel

@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *extends;
@property (nonatomic, strong) NSString *idx;
@property (nonatomic, strong) NSString *moreLink;
@property (nonatomic, strong) NSString *handler;

@property (nonatomic, strong) NSArray<SpecialItemsList,ConvertOnDemand> *itemsList;

@end














