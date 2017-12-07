//
//  HYTransModel.h
//  TourGuidShop
//
//  Created by Black on 17/6/21.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYModel.h"

@interface HYTransModel : HYModel

@property (nonatomic, assign) HYFinishStatus finishStatus;
@property (nonatomic, copy)   NSString *out_trans_ID;
@property (nonatomic, copy)   NSString *payTime;
@property (nonatomic, copy)   NSString *payment_channel; // 支付状态
@property (nonatomic, copy)   NSString *payment_channel_icon; // 支付logo
@property (nonatomic, copy)   NSString *payment_channel_name; // 支付名称
@property (nonatomic, copy)   NSString *refund_reason; // 退款原因
@property (nonatomic, assign) HYRefundReason refund_reason_type; // 退款类型 1,2,9
@property (nonatomic, copy)   NSString *refund_succ_time; // 退款成功实践
@property (nonatomic, copy)   NSString *refund_time; // 退款发起时间
@property (nonatomic, copy)   NSString *settle_amount; // 结算金额
@property (nonatomic, assign) HYSettleStatus settleStatus; // 清算状态
@property (nonatomic, copy)   NSString *trans_amount; // 交易金额
@property (nonatomic, copy)   NSString *trans_amount_cny; // 交易符号
@property (nonatomic, copy)   NSString *trans_currency; // 交易符号
@property (nonatomic, copy)   NSString *trans_ID; // 交易ID
@property (nonatomic, copy)   NSString *trans_title;
@property (nonatomic, assign) BOOL isChange; // 是否改变

@property (nonatomic, assign) BOOL isRequesrtFail;


@property (nonatomic, strong) NSArray *messageArray;
@property (nonatomic, strong) NSArray *titleArray;

+ (instancetype)createWithDic:(NSDictionary *)dic;

/**
 *  获取信息列表
 */

- (void)reloadTransMessageArray;


@end
