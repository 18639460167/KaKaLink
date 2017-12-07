//
//  HYSaleMonthModel.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/29.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSaleMonthModel.h"

@implementation HYSaleMonthModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.time = [NSString trimNSNullTimeYear:[dic objectForKey:@"date_label"]];
        self.sale = [NSString trimNSNullAsFloatZero:[dic objectForKey:@"sale"]];
        self.income = [NSString trimNSNullAsFloatZero:[dic objectForKey:@"income"]];
    }
    return self;
}
@end
