//
//  NavsModel.h
//  Travel
//
//  Created by qf1 on 16/1/25.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "JSONModel.h"

@protocol ItemsList <NSObject>

@end


@interface ItemsList : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *gmt_expired;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *handler;



@end

@interface NavsModel : JSONModel

@property (nonatomic, strong) NSArray<ItemsList,ConvertOnDemand> *itemsList;
@end











