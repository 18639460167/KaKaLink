//
//  HYTransModel.m
//  TourGuidShop
//
//  Created by Black on 17/6/21.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYTransModel.h"

@implementation HYTransModel

+ (instancetype)createWithDic:(NSDictionary *)dic
{
    HYTransModel *model = [[HYTransModel alloc]initWithDidc:dic];
    return model;
}

- (instancetype)initWithDidc:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.trans_title = [NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"trans_title")];
        self.trans_ID = [NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"trans_id")];
        self.trans_currency = [NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"trans_currency")];
        self.trans_amount_cny = [NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"trans_amount_cny")];
        self.trans_amount = [NSString trimNSNullAsZero:DIC_KEY_VALUE(dic, @"trans_amount")];
        self.settle_amount = [NSString trimNSNullAsZero:DIC_KEY_VALUE(dic, @"settle_amount")];
        self.settleStatus = [HYModel getSettleStatus:[NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"settlement_status")]];
        self.refund_time = [NSString trimNSNullASTimeValue:DIC_KEY_VALUE(dic, @"refund_time")];
        self.refund_succ_time = [NSString trimNSNullASTimeValue:DIC_KEY_VALUE(dic, @"refund_succ_time")];
        self.refund_reason_type = [HYModel getRefunReasonStatus:[NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"refund_reason_type")]];
        self.refund_reason = [HYModel getRefundReason:self.refund_reason_type reason:[NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"refund_reason")]];
        self.payment_channel = [NSString trimnsNullasIntValue:DIC_KEY_VALUE(dic, @"payment_channel")];
        self.payment_channel_icon = [NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"payment_channel_icon")];
        self.payment_channel_name = [NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"payment_channel_name")];
        self.payTime = [NSString trimNSNullASTimeValue:DIC_KEY_VALUE(dic, @"pay_time")];
        self.out_trans_ID = [NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"out_trans_id")];
        self.finishStatus = [HYModel getFinishStatus:[NSString trimNSNullAsNoValue:DIC_KEY_VALUE(dic, @"finish_status")]];
        self.isChange = NO;
    }
    return self;
}

- (void)reloadTransMessageArray
{
    if (self.isRequesrtFail == NO)
    {
        self.titleArray = [NSArray new];
        self.messageArray = [NSArray new];
    }
    else
    {
        NSArray *oneArray = [NSArray new];
        NSArray *twoArray = [NSArray new];
        if (self.finishStatus == HYFinishStatus_Success)
        {
            oneArray = @[self.trans_amount,[self.settle_amount addMoneyUnit],@"",self.payment_channel_name,self.trans_title];
            if (self.isChange)
            {
                self.payTime = [NSString getCurrentTime];
            }
            twoArray = @[self.payTime,self.trans_ID,self.out_trans_ID];
        }
        else
        {
            oneArray = @[self.trans_amount,[self.settle_amount addMoneyUnit],@"",self.payment_channel_name,self.trans_title,self.payTime,self.trans_ID,self.out_trans_ID];
            if (self.finishStatus == HYFinishStatus_RefundEd)
            {
                twoArray = @[self.refund_succ_time,self.refund_reason];
            }
            else
            {
                if (self.isChange)
                {
                    self.refund_time = [NSString getCurrentTime];
                }
                twoArray = @[self.refund_time,self.refund_reason];
            }
        }
        self.messageArray = @[oneArray,twoArray];
        [self transTitleArray];

    }
}

- (void)transTitleArray
{
    if (self.finishStatus == HYFinishStatus_Success)
    {
       NSArray * statusArray = @[LS(@"Actual_Receivable"),LS(@"Settlement_Amount"),LS(@"Trading_Status"),LS(@"Channels_Payment"),LS(@"Payment_Business")];
      NSArray *  messageArray = @[LS(@"Transaction_Time"),LS(@"Transaction_Number"),LS(@"Payment_Code")];
        self.titleArray = @[statusArray,messageArray];
    }
    else
    {
       NSArray *statusArray = @[LS(@"Actual_Receivable"),LS(@"Settlement_Amount"),LS(@"Trading_Status"),LS(@"Channels_Payment"),LS(@"Payment_Business"),LS(@"Transaction_Time"),LS(@"Transaction_Number"),LS(@"Payment_Code")];
      NSArray * messageArray = @[LS(@"Refund_Start_Time"),LS(@"Refund_Reason")];
        self.titleArray = @[statusArray,messageArray];
    }
}

@end
