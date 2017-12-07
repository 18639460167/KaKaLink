//
//  HYSettleListModel.m
//  TourGuidShop
//
//  Created by Black on 17/6/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSettleListModel.h"

@implementation HYSettleListModel

+ (instancetype)createWithDic:(NSDictionary *)dic
{
    HYSettleListModel *model = [[HYSettleListModel alloc]initWithDic:dic];
    return model;
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.amount = [NSString trimNSNullAsZero:DIC_KEY_VALUE(dic, @"amount")];
        self.createTime = [NSString trimNSNullASTimeValue:DIC_KEY_VALUE(dic, @"create_time")];
        self.mID = [NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"mid")];
        self.settlement_id = [NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"settlement_id")];
        self.title = [NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"title")];
    }
    return self;
}

@end
