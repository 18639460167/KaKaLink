//
//  HYSaleQueryModel.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/30.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYModel.h"

@interface HYSaleQueryModel : HYModel

@property (nonatomic, copy) NSString *pay_time;
@property (nonatomic, copy) NSString *pay_channel;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *transaction_id;
@property (nonatomic, copy) NSString *pay_id;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *settle_price;
@property (nonatomic, copy) NSString *finish_status;
@property (nonatomic, copy) NSString *refund_reason;
@property (nonatomic, copy) NSString *refund_time;
@property (nonatomic, copy) NSString *refund_succ_time;
@property (nonatomic, copy) NSString *refund_reason_type;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
