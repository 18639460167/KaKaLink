//
//  HYTransViewModel.h
//  TourGuidShop
//
//  Created by Black on 17/6/21.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYModel.h"

@interface HYTransViewModel : HYModel

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger orderTotal; //总条数
@property (nonatomic, assign) HYFinishStatus finishStatus; // 订单状态
@property (nonatomic, strong) NSMutableArray *orderListArray; // 订单数组
@property (nonatomic, copy)   NSString *mID; // 商铺ID
@property (nonatomic, copy)   NSString *channel; // 支付ID

@property (nonatomic, copy) NSString *totalCount; // 总条数
@property (nonatomic, copy) NSString *total_settle_amout; // 交易金额
@property (nonatomic, assign) BOOL isRequestFailed; //是否请求失败


- (void)modelReloadData;
/**
 *  0全部，1今天，2之前
 */
@property (nonatomic, copy) NSString *period; //订单周期

- (void)loadNewOrderList:(HYHandler)complete;

- (void)loadMoreOrder:(HYHandler)complete;

/**
 *  订单详情
 */
+ (void)getTransDetail:(NSString *)orderID handler:(void(^)(NSString *status,HYTransModel *model))complete;

/**
 *  订单退款
 */
+ (void)setOrderRefund:(NSString *)trans_id  refund_reason_type:(NSString *)type reason:(NSString *)reason  pass:(NSString *)pass handler:(HYHandler)complete;

/**
 *  取消退款
 */
+ (void)setCancelRefund:(NSString *)trans_id pass:(NSString *)pass handler:(HYHandler)complete;
@end
