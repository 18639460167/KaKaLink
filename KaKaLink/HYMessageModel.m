//
//  HYMessageModel.m
//  TourGuidShop
//
//  Created by Black on 17/6/21.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYMessageModel.h"

@implementation HYMessageModel

+ (instancetype)createDic:(NSDictionary *)dic
{
    HYMessageModel *model = [[HYMessageModel alloc]initWithDic:dic];
    return model;
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.isSelect = NO;
        self.icon_url = [NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"icon_url")];
        self.tID = [NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"id")];
        self.title = [NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"title")];
    }
    return self;
}
@end
