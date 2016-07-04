//
//  ZJFVideosModel.h
//  Travel
//
//  Created by qf1 on 16/2/4.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

//{
//    "content": [
//                {
//                    "id": 100,
//                    "tags": "玩户外",
//                    "name": "触摸三奥神山,徒步巴谷多峰",
//                    "sightName": "阿坝藏族羌族自治州",
//                    "sightParentName": "四川省",
//                    "imageHref": "http://file.saygoer.com/tv/20160203/ab084f4f-1a28-4c0c-bb42-5641f994c4b4.JPEG",
//                    "links": {
//                        "intro": "http://api.lvshiv.com/travelVideos/100/intro",
//                        "self": "http://api.lvshiv.com/travelVideos/100",
//                        "share": "http://api.lvshiv.com/travelVideos/100/share"
//                    }
//                },

#import "JSONModel.h"

@protocol ContentModel <NSObject>
@end

@interface ContentModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *myId;
@property (nonatomic, copy) NSString<Optional> *tags;
@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic, copy) NSString<Optional> *sightName;
@property (nonatomic, copy) NSString<Optional> *sightParentName;
@property (nonatomic, copy) NSString<Optional> *imageHref;
@property (nonatomic, strong) NSDictionary<Optional> *links;
@end


@interface ZJFVideosModel : JSONModel

@property (nonatomic, copy) NSString *totalPages;
@property (nonatomic, strong) NSDictionary *links;
@property (nonatomic, strong) NSArray<ContentModel,ConvertOnDemand> *content;
@end
















