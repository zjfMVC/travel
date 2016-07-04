//
//  RouteModel.h
//  Travel
//
//  Created by qf1 on 16/1/25.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
//"alias": "route",
//"name": "周边游",
//"itemsList": [],
//"extends": [ ],
//"idx": "4",
//"moreLink": "http://app2.youxiake.com/n.php/activity,group,detail?alias=PAGE_TYPE_ZHOUBIAN&type=11",
//"handler": "product_list"

//"itemsList": [
//              {
//                  "title": "冰雪龙王山",
//                  "url": "11656",
//                  "thumb": "http://qimg5.youxiake.com/app/201512/31/pager/568508d40695b.jpg!p6",
//                  "gmt_expired": "2016-02-10",
//                  "handler": "product_detail"
//              },

#import "JSONModel.h"

@protocol RouteItemsList <NSObject>
@end


@interface RouteItemsList : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *gmt_expired;
@property (nonatomic, strong) NSString *handler;


@end

@interface RouteModel : JSONModel

@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *extends;
@property (nonatomic, strong) NSString *idx;
@property (nonatomic, strong) NSString *moreLink;
@property (nonatomic, strong) NSString *handler;

@property (nonatomic, strong) NSArray<RouteItemsList,ConvertOnDemand> *itemsList;
@end



















