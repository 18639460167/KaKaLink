//
//  HYModel.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/6.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYModel.h"

@implementation HYModel

+ (NSString *)getFinishString:(HYFinishStatus)status
{
    NSString *statusMessage = @"-1";
    switch (status)
    {
        case HYFinishStatus_Success:
        {
            statusMessage = @"1";
        }
            break;
        case HYFinishStatus_Progress:
        {
            statusMessage = @"2";
        }
            break;
        case HYFinishStatus_RefundEd:
        {
            statusMessage = @"3";
        }
            break;
            
        default:
            break;
    }
    return statusMessage;
}

+ (HYFinishStatus)getFinishStatus:(NSString *)statusMessage
{
    HYFinishStatus status = HYFinishStatus_UnKnow;
    if ([statusMessage isEqualToString:@"1"])
    {
        status = HYFinishStatus_Success;
    }
    else if ([statusMessage isEqualToString:@"2"])
    {
        status = HYFinishStatus_Progress;
    }
    else if ([statusMessage isEqualToString:@"3"])
    {
        status  =HYFinishStatus_RefundEd;
    }
    return status;
}

#pragma mark - 获取结算状态

+ (NSString *)getSettleString:(HYSettleStatus)status
{
    NSString *message = @"-1";
    switch (status)
    {
        case HYSettleStatus_Success:
        {
            message = @"1";
        }
            break;
        case HYSettleStatus_Progress:
        {
            message  = @"0";
        }
            break;
            
        default:
            break;
    }
    return message;
}

+ (HYSettleStatus )getSettleStatus:(NSString *)statusMessage
{
    HYSettleStatus status = HYSettleStatus_UnKnow;
    if ([statusMessage isEqualToString:@"1"])
    {
        status = HYSettleStatus_Success;
    }
    else if ([statusMessage isEqualToString:@"0"])
    {
        status = HYSettleStatus_Progress;
    }
    return status;
}

#pragma makr - 获取退款远影

+ (NSString *)getRefundReason:(HYRefundReason)reason reason:(NSString *)title
{
    NSString *message = title;
    switch (reason)
    {
        case HYRefundReason_MorePay:
        {
            message =  LS(@"Many_Times_Pay");
        }
            break;
        case HYRefundReason_UnSame:
        {
            message = LS(@"Business_Negotiations");
        }
            break;
            
        default:
            break;
    }
    return message;
}
+ (HYRefundReason)getRefunReasonStatus:(NSString *)statusMessage
{
    HYRefundReason reason = HYRefundReason_Other;
    if ([statusMessage isEqualToString:@"1"])
    {
        reason = HYRefundReason_MorePay;
    }
    else if ([statusMessage isEqualToString:@"2"])
    {
        reason = HYRefundReason_UnSame;
    }
    return reason;
}

+ (HYRefundReason)chooseReason:(NSString *)statusMessage
{
    HYRefundReason reason = HYRefundReason_Other;
    if ([statusMessage isEqualToString:LS(@"Many_Times_Pay")])
    {
        reason = HYRefundReason_MorePay;
    }
    if ([statusMessage isEqualToString:LS(@"Business_Negotiations")])
    {
        reason = HYRefundReason_UnSame;
    }
    return reason;
}
@end
