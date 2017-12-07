//
//  HYWithdrawModel.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/6.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYWithdrawModel.h"

@implementation HYWithdrawModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.amount = [NSString trimNSNullAsNoValue:[dic objectForKey:@"amount"]];
        self.audit_time = [NSString trimNSNullASTimeValue:[dic objectForKey:@"audit_time"]];
        self.audit_reson = [NSString trimNSNullAsNoValue:[dic objectForKey:@"audit_reason"]];
        self.audit_status = [NSString trimNSNullAsNoValue:[dic objectForKey:@"audit_status"]];
        self.withdraw_id = [NSString trimNSNullAsNoValue:[dic objectForKey:@"id"]];
        if ([[dic objectForKey:@"receipt_url"] isEqual:[NSNull null]] || [dic objectForKey:@"receipt_url"] == nil )
        {
            self.receipt_url = [NSArray new];
        }
        else
        {
            self.receipt_url = [dic objectForKey:@"receipt_url"];
        }
        
        self.create_time  =[NSString trimNSNullASTimeValue:[dic objectForKey:@"create_time"]];
    }
    return self;
}

@end
