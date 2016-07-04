//
//  VideosDetailModel.h
//  Travel
//
//  Created by qf1 on 16/2/6.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
//{
//    "id": 100,
//    "tags": "玩户外",
//    "name": "触摸三奥神山,徒步巴谷多峰",
//    "intro": "巴谷多雪山，是三奥雪山的守护山，巴谷多雪山主峰海拔4400米，位于中国青藏高原东麓，四川阿坝藏族羌族自治州的黑水县境内，距黑水县城芦花镇16公里，距成都310公里。巴谷多位于黑水县芦花镇，距县城16公里。巴谷多是一座普级型山峰，行进路线清晰，风景优美，适合初级户外运动爱好者体验徒步露营、骑马观光、登山摄影的好去处，适合做大团队活动项目。顶峰距离沟底直线上升高度大约2100米左右。屹立顶峰纵观全览整个黑水地区，更能亲密接触三奥雪山.",
//    "videoDuration": 78,
//    "imageHref": "http://file.saygoer.com/tv/20160203/ab084f4f-1a28-4c0c-bb42-5641f994c4b4.JPEG",
//    "videoHref": "http://7xn3hc.media1.z0.glb.clouddn.com/ltDf3LVgbi1KPabMfXf6qXtlMMe3",
//    "links": {
//        "intro": "http://api.lvshiv.com/travelVideos/100/intro",
//        "self": "http://api.lvshiv.com/travelVideos/100",
//        "share": "http://api.lvshiv.com/travelVideos/100/share"
//    }
//}
#import "JSONModel.h"

@interface VideosDetailModel : JSONModel

@property (nonatomic, copy) NSString *myId;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *videoDuration;
@property (nonatomic, copy) NSString *imageHref;
@property (nonatomic, copy) NSString *videoHref;
@property (nonatomic, strong) NSDictionary *links;

@end










