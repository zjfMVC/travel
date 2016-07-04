//
//  VideosDetailModel+Net.h
//  Travel
//
//  Created by qf1 on 16/2/6.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "VideosDetailModel.h"

typedef void(^CompletionBlock)(VideosDetailModel *VideosDetailModel,NSError *error);
@interface VideosDetailModel (Net)

+(void)requestVideosDetailModelWithUrl:(NSString *)url compltionBlock:(CompletionBlock )block;

@end
