//
//  FreeWaikModel.h
//  Travel
//
//  Created by qf1 on 16/2/16.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
//"data": [
//         {
//             "productType": "1016",
//             "productTypeEngDesc": "flights",
//             "departureTime": "一月,二月,三月,四月,五月,六月",
//             "price": "<em>1299</em>元起",
//             "sale_count": "534",
//             "_id": 0,
//             "id": "54683",
//             "openType": 1,
//             "title": "【节后特价】上海直飞东京5天往返含税机票（2人出行赠WIFI）",
//             "url": "http://m.qyer.com/z/deal/54683?source=app2&client_id=qyer_discount_androi&track_app_version=1.9.0.1&track_deviceid=359209022229573&ra_referer=app_home&ra_model=recommend",
//             "imgUrl": "http://pic.qyer.com/public/lastmin/lastminute/2016/02/04/14545670661496/600x400",
//             "type": "deal",
//             "ra_n_model": "recommend"
//         },
#import <Foundation/Foundation.h>

@interface FreeWalkModel : NSObject

@property (nonatomic, copy) NSString *productType;
@property (nonatomic, copy) NSString *departureTime;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *sale_count;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *imgUrl;

@end








