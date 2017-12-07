//
//  HYModel.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/6.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,HYFinishStatus){
    HYFinishStatus_Success, // 已成交
    HYFinishStatus_Progress, // 退款中
    HYFinishStatus_RefundEd, // 已退款
    HYFinishStatus_UnKnow // 未知
};

typedef NS_ENUM(NSUInteger,HYSettleStatus) {
    HYSettleStatus_Success, // 已清算
    HYSettleStatus_Progress, // 未清算
    HYSettleStatus_UnKnow // 未知
};

typedef NS_ENUM(NSUInteger,HYRefundReason) {
    HYRefundReason_UnSame, // 协商不一致
    HYRefundReason_MorePay, // 多次支付
    HYRefundReason_Other //其他
};


@interface HYModel : NSObject

/**
 *  状态转文本
 *
 *  @param status 状态
 *
 *  @return 1,2,3,4
 */
+ (NSString *)getFinishString:(HYFinishStatus)status;

/**
 *  文本转状态
 *
 *  @param statusMessage 状态
 *
 *  @return 
 */
+ (HYFinishStatus)getFinishStatus:(NSString *)statusMessage;


+ (NSString *)getSettleString:(HYSettleStatus)status;

+ (HYSettleStatus)getSettleStatus:(NSString *)statusMessage;

+ (NSString *)getRefundReason:(HYRefundReason)reason reason:(NSString *)title;
+ (HYRefundReason)getRefunReasonStatus:(NSString *)statusMessage;
+ (HYRefundReason)chooseReason:(NSString *)statusMessage;


@end
