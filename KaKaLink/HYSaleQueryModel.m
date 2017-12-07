//
//  HYSaleQueryModel.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/30.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSaleQueryModel.h"

@implementation HYSaleQueryModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.pay_time = [NSString trimNSNullASTimeValue:[dic objectForKey:@"pay_time"]];
        self.pay_channel = [NSString trimNSNullAsNoValue:[dic objectForKey:@"pay_channel"]];
        self.title = [NSString trimNSNullAsNoValue:[dic objectForKey:@"title"]];
        self.transaction_id = [NSString trimNSNullAsNoValue:[dic objectForKey:@"transaction_id"]];
        self.pay_id = [NSString trimNSNullAsNoValue:[dic objectForKey:@"pay_id"]];
        self.price = [NSString trimNSNullAsNoValue:[dic objectForKey:@"price"]];
        self.settle_price = [NSString trimNSNullAsNoValue:[dic objectForKey:@"settle_price"]];
        self.finish_status = [NSString trimNSNullAsNoValue:[dic objectForKey:@"finish_status"]];
        self.refund_reason = [NSString trimNSNullAsNoValue:[dic objectForKey:@"refund_reason"]];
        self.refund_time = [NSString trimNSNullAsNoValue:[dic objectForKey:@"refund_time"]];
        self.refund_succ_time = [NSString trimNSNullAsNoValue:[dic objectForKey:@"refund_succ_time"]];
        self.refund_reason_type = [NSString trimNSNullAsNoValue:[dic objectForKey:@"refund_reason_type"]];
    }
    return self;
}

@end
